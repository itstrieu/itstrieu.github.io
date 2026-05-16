# Stack Audit — itstrieu.github.io

Audited: 2026-05-15
Auditor: Front-End Dev agent

---

## 1. Jekyll Version and Dependencies

**Jekyll version:** 4.3.4 (via Gemfile.lock, line 21)
**Ruby version:** 3.2.2 specified in GitHub Actions workflow (`.github/workflows/jekyll.yml`, line 39). No `.ruby-version` file in the repo. The `vendor/bundle` directory contains Ruby 3.3.0 gems, suggesting local dev may run a different Ruby than CI.
**Bundler:** 2.5.21 (Gemfile.lock line 93), Gemfile requires >= 2.5.20.

**Gem dependencies:**

| Gem | Locked version | Latest (approx.) | Notes |
|-----|---------------|-------------------|-------|
| jekyll | 4.3.4 | 4.4.x | One minor version behind |
| jekyll-feed | 0.17.0 | 0.17.0 | Current |
| jekyll-paginate | 1.1.0 | 1.1.0 | Abandoned upstream; last release 2014 |
| jekyll-seo-tag | 2.8.0 | 2.8.0 | Current |
| jekyll-sitemap | 1.4.0 | 1.4.0 | Current |
| millennial | 2.0.0 | 2.0.0 | Theme gem |
| kramdown | 2.4.0 | 2.5.x | One minor behind |
| rouge | 4.4.0 | 4.5.x | Close to current |

**Issue — Gemfile source uses HTTP:** `Gemfile` line 1 uses `source "http://rubygems.org"` (no TLS). Should be `https://rubygems.org`. This is a security risk — gem downloads are unencrypted and vulnerable to MITM.

**Issue — Gemfile.lock platform mismatch:** `PLATFORMS` section (line 82) lists only `x64-mingw-ucrt` (Windows). The GitHub Actions runner is `ubuntu-22.04`. The lock file was generated on Windows and may cause `bundle install` failures in CI if platform-specific gems differ. Bundler's cache step in CI may mask this, but it is fragile.

**Issue — vendored gems committed:** The repo contains a `vendor/bundle/ruby/3.3.0/` directory with installed gems. This bloats the repo and is unnecessary given CI uses `bundler-cache: true`. Should be gitignored.

---

## 2. Theme Status

**Theme:** Millennial v2.0.0 by Paul Le ([GitHub](https://github.com/LeNPaul/Millennial))

**Fully vendored, not gem-based in practice.** Although the Gemfile references `gem "millennial"` and a `millennial.gemspec` exists in the repo root, the repo contains all theme files locally:
- `_layouts/` — 5 files (category, default, home, page, post)
- `_includes/` — 9 files
- `_sass/` — 10 files (573 lines total)
- `assets/css/` — main.scss, syntax.css
- `millennial.gemspec` at repo root

This means the theme is **vendored and editable in-place**. The gemspec is vestigial from forking the theme repo. Any changes to layouts, includes, or Sass take effect directly — no gem override mechanism needed.

**Customizations vs. defaults:**
- `_data/settings.yml` — Disqus disabled, Google Analytics ID empty, menu configured for About/Contact, social links set to GitHub/LinkedIn/RSS
- `_config.yml` — standard configuration, title/description/author customized
- `about.md` and `contact.md` — custom content in `pages/`
- `featured-post.html` — appears to have been simplified from the original Millennial theme (no image in post cards on the home page, just title + description + date)

Everything else appears to be default Millennial theme code.

---

## 3. Build Pipeline

**Deployment method:** Custom GitHub Actions workflow (`.github/workflows/jekyll.yml`)

**Build steps:**
1. Checkout (actions/checkout@v4)
2. Setup Ruby 3.2.2 with bundler-cache (ruby/setup-ruby@v1.161.0, pinned by SHA)
3. Configure Pages (actions/configure-pages@v5)
4. `bundle exec jekyll build` with `JEKYLL_ENV=production`
5. Upload artifact (actions/upload-pages-artifact@v3)
6. Deploy to GitHub Pages (actions/deploy-pages@v4)

**Trigger:** Push to `main` branch, plus manual `workflow_dispatch`.

**Concurrency:** Group "pages", no cancel-in-progress (correct for production deploys).

**Issues:**
- `ubuntu-22.04` is approaching end-of-life (April 2027). Not urgent but worth bumping to `ubuntu-latest` or `ubuntu-24.04` eventually.
- The Ruby setup action is pinned by SHA (`8575951200e472d5f2d95c625da0c7bec8217c42`), which is good for reproducibility but may miss security patches. Comment says v1.161.0.

---

## 4. Layouts Inventory

| File | Parent | Purpose | Issues |
|------|--------|---------|--------|
| `default.html` | none | Base shell: head, header, content, footer | Missing `lang="en"` on `<html>` tag (line 2). Accessibility and SEO deficiency. |
| `home.html` | default | Paginated post list on index | **Pagination bug:** "Newer" button uses `site.github.url` (line 13) but "Older" button uses `site.baseurl` (line 18). Inconsistent URL construction. Also, the labels are swapped: `next_page` link shows `previous_page` text and vice versa — this is intentional (older = previous page number, newer = next page number) but confusing in the code. |
| `post.html` | default | Single blog post | References `site.github.url` for featured image (line 14). Conditional blocks for date, share buttons, related posts, and Disqus — all functional. |
| `page.html` | default | Static pages (About, Contact, 404) | Clean, no issues. |
| `category.html` | default | Lists posts in a category | Iterates all `site.posts` and filters by `page.category`. No category pages actually exist in the repo — this layout is dead code unless category pages are created. |

---

## 5. Includes Inventory

| File | Used by | Status | Notes |
|------|---------|--------|-------|
| `head.html` | default.html | **Active** | Loads CSS, Google Fonts, Font Awesome 4.6.3 (outdated, current is 6.x), MathJax 2.7.5 (outdated, current is 3.x), jekyll-feed meta, jekyll-seo-tag. |
| `header.html` | default.html | **Active** | Site title, nav menu, mobile dropdown. Duplicates menu HTML for desktop and mobile (lines 6-12 vs 16-22). |
| `footer.html` | default.html | **Active** | Social icons, site description line. |
| `featured-post.html` | home.html, category.html | **Active** | Post card component. Links use `site.github.url`. |
| `post-date.html` | post.html | **Active** | Formatted date with ordinal suffixes (1st, 2nd, 3rd). |
| `post-share.html` | post.html | **Active but stale** | Share buttons for Twitter and Facebook only. Uses `site.github.url`. Twitter link uses old `twitter.com/intent/tweet` format (still works but the platform is now X). No LinkedIn sharing. |
| `related-posts.html` | post.html | **Active** | Tag-based related posts, limit 2 per tag. Mixes `site.github.url` and `site.url + site.baseurl` for image URLs (line 14 vs line 11). Inconsistent. |
| `disqus.html` | post.html | **Dead code** | Disqus is disabled in `_data/settings.yml` (line 3: `comments: false`). The include is guarded by `{% if site.data.settings.disqus.comments %}` in post.html (line 27), so it never renders. Safe to remove. |
| `google-analytics.html` | head.html | **Dead code** | Uses legacy `analytics.js` (Universal Analytics), which Google sunset in July 2024. The tracking ID is empty (`google-ID: ''` in settings.yml line 7). Even if an ID were set, this would send data to a deprecated endpoint. Uses the `ga()` function which no longer works for new properties. |

---

## 6. Asset Management

**CSS:**
- `assets/css/main.scss` — SCSS entry point, defines variables, imports `_sass/_-sections-dir.scss` which imports all partials.
- `assets/css/syntax.css` — Code syntax highlighting (static CSS, not SCSS).
- 10 SCSS partials in `_sass/`, totaling 573 lines. Manageable.
- External: Google Fonts (Roboto, Source Code Pro), Font Awesome 4.6.3 via CDN.

**JavaScript:**
- No custom JS files.
- External: MathJax 2.7.5 via CDN (loaded on every page, even non-math posts).
- Google Analytics script (dead, as noted above).

**Images:**
- All in `assets/img/`. Mix of blog images and PDF certificates.
- **Large unoptimized files:**
  - `tbb.mp4` — 8.0 MB (video file served as a static asset)
  - `tbb.gif` — 2.2 MB (GIF version of same content)
  - `flower.jpg` — 1.6 MB
  - `chatgpt.jpg` — 1.3 MB
  - `start.jpg` — 1.1 MB
  - `pi.jpg` — 1.1 MB
  - `welcome.jpg` — 1.0 MB
- Total image directory is ~18 MB. No WebP or AVIF versions. No responsive `srcset` usage.
- 6 PDF certificate files stored in `assets/img/` — misplaced (should be in `assets/docs/` or similar if needed at all).

**No favicon beyond `favicon.ico`** — no apple-touch-icon, no manifest.json, no modern favicon set.

---

## 7. Plugin Compatibility

All four plugins are GitHub Pages whitelisted:

| Plugin | GH Pages compatible | Notes |
|--------|-------------------|-------|
| jekyll-paginate | Yes | Deprecated in favor of jekyll-paginate-v2, but v2 is NOT GH Pages compatible. Since we use a custom Actions build, v2 would work, but switching is optional. |
| jekyll-sitemap | Yes | Works fine. |
| jekyll-feed | Yes | Generates Atom feed. The separate `rss-feed.xml` is a manual RSS 2.0 template that duplicates this. |
| jekyll-seo-tag | Yes | Works fine. Adds OG tags, Twitter cards, etc. |

Since the site uses a custom GitHub Actions workflow (not the default GH Pages build), there is **no plugin restriction**. Any Jekyll plugin can be used. This is an underutilized advantage.

---

## 8. Technical Debt

### High priority

1. **`site.github.url` usage everywhere.** This variable is populated by the `github-metadata` gem on GitHub Pages, but that gem is NOT in the Gemfile. Locally, `site.github.url` resolves to nil. In production via GitHub Actions, it may or may not be populated depending on the environment. The correct pattern is `{{ site.url }}{{ site.baseurl }}` or just `{{ site.baseurl }}` for relative paths. Found in 13 locations across layouts and includes.

2. **`baseurl: "/"` in `_config.yml` (line 18).** Jekyll convention is that `baseurl` should be empty string `""` for root-deployed sites, or `/subpath` for project pages. Setting it to `"/"` means `{{ site.baseurl }}/about` renders as `//about` (double slash). This interacts badly with the `site.github.url` usage and pagination URLs.

3. **Insecure gem source** (`Gemfile` line 1): `http://` instead of `https://`.

4. **Gemfile.lock platform is Windows-only** while CI runs Ubuntu.

### Medium priority

5. **Tag formatting is broken across posts.** Multi-word tags are split into single words in some posts:
   - `_posts/2025-02-19-learning_log.md`: tags `Machine`, `Learning`, `AI`, `Career`, `Progression` (5 separate tags instead of "Machine Learning", "Career Progression")
   - `_posts/2025-04-06-tennis_ball_bot_progress.md`: tags `Machine`, `Learning`, `AI`, `Career`, `Robotics`, `Object`, `Detection`, `Computer`, `Vision`, `YOLO`, `Tennis` (11 single-word tags)
   - `_posts/2025-03-16-sunday-summary-2.md`: tags `Machine Learning`, `AI`, `Career`, `Progression`, `Productivity` (correct multi-word format)
   
   This inconsistency means related-posts matching is unreliable. A post tagged `Machine` will not match a post tagged `Machine Learning`.

6. **Font Awesome 4.6.3 is end-of-life.** Current version is 6.x with a completely different icon naming scheme. FA 4 CDN could be removed at any time.

7. **MathJax 2.7.5 loaded on every page** (`_includes/head.html` line 20-22). Most posts don't use math. This adds ~70KB+ of JS to every page load. Should be conditionally loaded or upgraded to MathJax 3.x (which is significantly smaller and faster).

8. **Duplicate RSS feeds.** `jekyll-feed` generates an Atom feed at `/feed.xml`, and there is a manual `rss-feed.xml` at the repo root. The Atom feed is linked via `{% feed_meta %}` in head.html. The RSS feed link is commented out in head.html (line 15-17). The manual `rss-feed.xml` is redundant.

9. **Google Analytics include is dead code** — using sunset Universal Analytics with empty ID.

10. **Post share buttons reference Twitter** — platform rebranded to X; also no LinkedIn share button despite LinkedIn being a primary social link.

### Low priority

11. **No `lang` attribute on `<html>` tag** (`_layouts/default.html` line 2). Hurts accessibility and SEO.

12. **No `alt` attributes on images** in `post.html` line 14 (`featured-image` img tag) or `related-posts.html` line 14.

13. **PDFs stored in `assets/img/`** directory — organizational issue.

14. **`vendor/bundle/` committed to repo** — should be in `.gitignore`.

15. **`category.html` layout exists but no category pages exist** — dead code.

---

## 9. Capabilities — What We Can Do Within the Current Setup

The custom GitHub Actions build means we are **not limited to GitHub Pages whitelisted plugins**. This opens up significant possibilities.

### Available now (no structural changes needed)

- **Fix URL construction** — replace `site.github.url` with proper `site.url`/`site.baseurl` pattern. Straightforward find-and-replace across ~13 locations.
- **Add OG images** — `jekyll-seo-tag` already supports `og:image`. Just add `image:` to post frontmatter (some posts already have this). Add a default OG image in `_config.yml` with `defaults` config.
- **Improve RSS** — `jekyll-feed` already works. Can enhance with author info, categories, and full content by adding `feed:` config to `_config.yml`. Remove the manual `rss-feed.xml`.
- **Add tag index page** — can build a single `/tags` page using Liquid that groups `site.tags`. No plugin needed.
- **Conditional MathJax** — wrap the MathJax script in `{% if page.mathjax %}` and only set `mathjax: true` in posts that need it.
- **Customize post cards** — `featured-post.html` is fully editable. Can add images, reading time, tags to post previews.
- **Add reading time** — pure Liquid: `{% assign words = content | number_of_words %}{% assign minutes = words | divided_by: 200 %}`.
- **Fix tag consistency** — standardize multi-word tags across all posts.
- **Improve 404 page** — currently uses `page` layout, could include search or recent posts.

### Available with minor additions

- **Tag pages per tag** — use `jekyll-archives` plugin (not GH Pages compatible, but fine with our Actions build) or generate them manually with a collection.
- **Search** — client-side with Lunr.js or similar. No server needed.
- **Dark mode** — CSS-only via `prefers-color-scheme` media query. The SCSS is structured well enough to add this.
- **Table of contents** — kramdown supports `{:toc}` natively. Just needs a CSS treatment.
- **Code copy button** — small JS addition.
- **Responsive images** — add `srcset` to image tags, serve WebP versions.

### Would require more work

- **CMS integration** — Decap CMS (formerly Netlify CMS) can be added as a static admin panel.
- **Comments replacement** — giscus (GitHub Discussions-based) to replace dead Disqus.
- **Newsletter integration** — Buttondown or similar, embedded form.
- **Analytics replacement** — Plausible, Fathom, or Umami to replace dead Google Analytics.

---

## 10. Recommended Upgrades (Prioritized)

### P0 — Fix broken things

1. **Fix `baseurl` in `_config.yml`** — change from `"/"` to `""`. Then replace all `site.github.url` references with `{{ site.url }}{{ site.baseurl }}` (or `{{ "/" | relative_url }}` for paths). This affects URL correctness across the entire site.
   - Files: `_config.yml` (line 18), plus 13 references in layouts/includes.

2. **Fix Gemfile source to HTTPS** — `Gemfile` line 1.

3. **Fix Gemfile.lock platform** — run `bundle lock --add-platform x86_64-linux` to add the CI platform. Or delete and regenerate on the correct platform.

4. **Standardize tags across all posts** — fix multi-word tag splitting in older posts.

### P1 — Remove dead code and reduce load

5. **Remove `google-analytics.html`** include and its reference in `head.html` (line 24). Universal Analytics is dead. If analytics are wanted later, add a modern solution.

6. **Remove or disable `disqus.html`** include. Already gated off but the file is unnecessary.

7. **Make MathJax conditional** — wrap in `{% if page.mathjax %}` in `head.html`. Saves ~70KB on every non-math page.

8. **Remove `rss-feed.xml`** — `jekyll-feed` already generates a proper Atom feed. One feed is enough.

### P2 — Improve quality and SEO

9. **Add `lang="en"` to `<html>` tag** in `default.html`.

10. **Add `alt` text to all `<img>` tags** in `post.html` and `related-posts.html`.

11. **Add default OG image** in `_config.yml` via `defaults` block, so posts without an `image:` frontmatter still have social sharing images.

12. **Update Font Awesome** from 4.6.3 to 6.x (or replace with inline SVGs to eliminate the CDN dependency entirely).

13. **Update share buttons** — replace Twitter with X, add LinkedIn.

### P3 — Modernize

14. **Optimize images** — compress JPGs, convert to WebP, add responsive `srcset`. The `assets/img/` directory is 18MB, much of which could be halved or more.

15. **Move PDFs out of `assets/img/`** to `assets/docs/`.

16. **Add `.ruby-version` file** to pin Ruby version and align local/CI environments.

17. **Gitignore `vendor/bundle/`** to reduce repo size.

18. **Upgrade MathJax to 3.x** if math support is still needed.

19. **Consider `jekyll-paginate-v2`** for more flexible pagination (tag/category pagination, custom page sizes). Only possible because of the custom Actions build.

---

## File Reference

| Path | What it is |
|------|-----------|
| `_config.yml` | Site configuration |
| `Gemfile` | Ruby dependencies |
| `Gemfile.lock` | Locked dependency versions |
| `millennial.gemspec` | Vestigial theme gemspec |
| `.github/workflows/jekyll.yml` | CI/CD pipeline |
| `_layouts/` | 5 layout templates |
| `_includes/` | 9 include partials |
| `_sass/` | 10 SCSS partials (573 lines) |
| `_data/settings.yml` | Theme settings (nav, social, Disqus, GA) |
| `_posts/` | 7 blog posts (Oct 2024 - May 2026) |
| `pages/about.md` | About page |
| `pages/contact.md` | Contact page |
| `assets/css/` | main.scss + syntax.css |
| `assets/img/` | Images + PDFs (~18MB) |
| `rss-feed.xml` | Manual RSS 2.0 feed (redundant) |
| `favicon.ico` | Favicon (basic) |
| `404.md` | Custom 404 page |
