# Design Spec: "it's trieu"

Literary warmth direction. Serif-first, typography-as-identity. No relation to Aeterna. Every value is final and CSS-ready.

---

## 1. Typography

**Google Fonts URL:**
```
https://fonts.googleapis.com/css2?family=Source+Serif+4:ital,opsz,wght@0,8..60,400;0,8..60,600;1,8..60,400;1,8..60,600&family=IBM+Plex+Mono:wght@400;500&display=swap
```

**Body text:** Source Serif 4, `18px`, weight `400`, `line-height: 1.75`. Optical sizing on (`font-optical-sizing: auto`). This is the entire identity of the site. The variable optical axis means it renders beautifully at reading sizes without looking spindly.

**Bold in body:** Source Serif 4, weight `600`. Not `700` -- `600` gives emphasis without shouting. She uses bold for emotional turning points; it needs to feel deliberate, not loud.

**Italic in body:** Source Serif 4 Italic, weight `400`. Used for inner monologue and book titles. The italic cut of Source Serif 4 is distinct enough to read as a voice shift.

**Headings:**

| Level | Size | Weight | Letter-spacing | Margin-top | Margin-bottom |
|-------|------|--------|----------------|------------|---------------|
| h1 | `1.75rem` (28px) | `600` | `-0.02em` | `0` | `0.25rem` |
| h2 | `1.35rem` (21.6px) | `600` | `-0.015em` | `2.5rem` | `0.75rem` |
| h3 | `1.125rem` (18px) | `600` | `-0.01em` | `2rem` | `0.5rem` |

Headings use Source Serif 4. No separate heading font. The weight shift from 400 to 600 is sufficient hierarchy. h1 appears only as the post title. h4-h6 are unlikely; style them as h3 if they appear.

**Meta text** (dates, nav, footer, post-nav labels): IBM Plex Mono, `13px`, weight `400`, `letter-spacing: 0.04em`, `text-transform: uppercase`, `color: #737373`. IBM Plex Mono is the blog's own monospace identity -- not DM Mono (Aeterna's). It is slightly warmer and more readable at small sizes.

**Code -- inline:** IBM Plex Mono, `0.875em` (relative to parent), weight `400`. Background `#f0eeeb`. Padding `0.15em 0.35em`. Border-radius `3px`. No border.

**Code -- fenced blocks:** IBM Plex Mono, `13.5px`, weight `400`, `line-height: 1.55`. Background `#f0eeeb`. Padding `1.25rem`. Border-radius `4px`. `overflow-x: auto`. No border, no line numbers.

---

## 2. Color

Light mode only. The content is long-form prose. Dark mode is a distraction from shipping.

| Token | Hex | Purpose |
|-------|-----|---------|
| `--bg` | `#fafaf8` | Page background. Warm near-white. Distinct from Aeterna's `#f5f2ec` -- cooler, less parchment. |
| `--text` | `#1a1a1a` | Body text. Near-black with enough warmth to not vibrate on the warm background. |
| `--text-secondary` | `#737373` | Dates, meta, footer text. Passes WCAG AA on `#fafaf8` at 4.85:1. |
| `--rule` | `#d6d3ce` | Dividers, borders, post-list separators. |
| `--code-bg` | `#f0eeeb` | Inline code and fenced code blocks. |
| `--accent` | `#8c6d4f` | Links (hover/active), site name hover. A muted umber -- warm brown with olive undertone. |
| `--link-underline` | `#c8c4bc` | Underline color on body links (resting state). |
| `--blockquote-border` | `#c8c4bc` | Left border on blockquotes. |

**Why umber for the accent:** The blog needs a color that is warm but not gold (Aeterna), not blue (generic), not green (tech startup). `#8c6d4f` is a muted warm brown -- the color of old book spines, of walnut, of espresso. It reads as "considered" and "grounded." It says the same thing the writing says: precise, unhurried, confident. It pairs naturally with Source Serif 4's editorial character. It is unmistakably not Aeterna's `#b8965a` gold -- darker, browner, zero brass.

---

## 3. Layout

**Content column:** `max-width: 640px`. Centered with `margin: 0 auto`. Padding `0 20px`. Box-sizing `border-box`. No visible container, no sidebar, no grid. Just a column of text.

### Home page

Post list. Each entry:
- Date in IBM Plex Mono uppercase, `13px`, `color: #737373`
- Title below the date, in Source Serif 4, `1.25rem`, weight `600`, `color: #1a1a1a`
- No excerpt, no image, no tag
- `2.5rem` vertical spacing between entries
- `1px solid #d6d3ce` rule between entries
- Title links are undecorated; on hover, color shifts to `#8c6d4f`

No excerpts. Seven posts, soon more, all with strong titles. The date-and-title format is honest: here is what I wrote, pick one.

Pagination: if post count exceeds 10, paginate at 10. "Older" / "Newer" links in IBM Plex Mono, `13px`, uppercase, with `0.04em` tracking. Centered. Color `#737373`, hover `#8c6d4f`.

### Post page

1. **Title:** h1, Source Serif 4, `1.75rem`, weight `600`, `-0.02em` tracking
2. **Date:** IBM Plex Mono, `13px`, uppercase, `0.04em` tracking, `color: #737373`. Margin-bottom `2.5rem`
3. **Content:** body text as specified above
4. **Section breaks (`<hr>`):** No visible line. `48px` vertical margin top and bottom (`margin: 48px 0`). `border: none`. The posts use `---` as chapter breaks between life phases. Visible lines would cheapen that. Breath is better.
5. **Post navigation:** Below content. Top border `1px solid #d6d3ce`. Padding-top `1.5rem`. Margin-top `3rem`. Two links: "Previous" and "Next" labels in IBM Plex Mono meta style, with post titles below in Source Serif 4 at `0.9375rem`. Previous floats left, next floats right. Use flexbox: `display: flex; justify-content: space-between`.

### Nav

Top of page. **Not fixed.** Scrolls with content. No shadow, no background distinction -- just part of the page.

- Left: site name "it's trieu" in IBM Plex Mono, `15px`, weight `500`, `letter-spacing: 0.03em`, lowercase, `color: #1a1a1a`. Links to home. Hover color `#8c6d4f`.
- Right: "About" link in IBM Plex Mono, `13px`, weight `400`, `letter-spacing: 0.04em`, uppercase, `color: #737373`. Hover color `#8c6d4f`.
- Padding: `1.5rem 0`. No border below.
- No hamburger menu. Two links always fit on one line, even at 320px.

### Footer

Below post navigation (on post pages) or below post list (on home). Margin-top `4rem`. Padding `2rem 0`. Border-top `1px solid #d6d3ce`.

Content: the tagline "building things, figuring things out." in IBM Plex Mono, `13px`, `color: #737373`, `letter-spacing: 0.04em`. Below it, "GitHub" and "LinkedIn" as text links separated by a middot (`·`), same meta style. Links are `color: #737373`, underline on hover.

Nothing else in the footer. No copyright, no "powered by," no icons.

---

## 4. Components

### Blockquotes

`margin: 1.75rem 0`. `padding: 0 0 0 1.25rem`. `border-left: 3px solid #c8c4bc`. Text `color: #4a4a4a`. Not italic -- she uses italics for inner monologue, not quotation. The blockquote's indent and muted color already signal "quoted." `font-size: 1rem` (slightly smaller than body, to set it apart without a full style change).

### Code blocks

Inline: as specified in Typography section. One visual: code in body text should not disrupt the reading line. The background tint and slight size reduction handle this.

Fenced: as specified. Syntax highlighting via Rouge (Jekyll default). Use a neutral highlight theme -- the existing `syntax.css` is fine as a base. Ensure the background matches `#f0eeeb`.

### Lists (ul, ol)

`margin: 1.25rem 0 1.25rem 1.5rem`. `li` margin-bottom `0.75rem`. Same body font, same size. Bullet style: default disc for ul, decimal for ol. No custom bullets.

### Links in body text

`color: #1a1a1a` (same as text). `text-decoration: underline`. `text-decoration-color: #c8c4bc`. `text-underline-offset: 3px`. On hover: `text-decoration-color: #8c6d4f`. `transition: text-decoration-color 0.2s ease`.

Links are ink-colored with a muted underline. The underline is the only signal. On hover, the underline warms to umber. This keeps the reading line clean while making links discoverable.

### Links in nav/footer

No underline. Color shift on hover only (`#737373` to `#8c6d4f`). `transition: color 0.2s ease`.

### Section breaks (hr)

`border: none`. `margin: 48px 0`. No visible element. These are structural breath, not decoration. She uses them to mark time jumps between life phases. A visible line would trivialize that.

### Post navigation (prev/next)

Container: `margin-top: 3rem; padding-top: 1.5rem; border-top: 1px solid #d6d3ce; display: flex; justify-content: space-between; gap: 2rem`.

Each link: label ("Previous" / "Next") in IBM Plex Mono meta style. Post title below in Source Serif 4, `0.9375rem`, weight `400`, `color: #1a1a1a`. Hover: title shifts to `#8c6d4f`. Previous aligns left, next aligns right with `text-align: right`. Each side gets `max-width: 45%`.

---

## 5. Mobile (below 640px)

**Font size:** Body stays `18px`. Do not shrink it. Readability is the entire point.

**Padding:** Content padding increases to `0 16px` below `480px`.

**Nav:** Both links stay on one line. Site name and About link. Padding `1.25rem 0`.

**Post list:** Vertical spacing between entries drops to `2rem`. Title size drops to `1.15rem`.

**Post navigation:** Stacks vertically. `flex-direction: column`. Previous on top, next below. Both full-width, left-aligned. Gap `1.5rem`.

**Code blocks:** `padding: 1rem`. `font-size: 13px`. `border-radius: 3px`.

**Touch targets:** All links in nav and footer have a minimum tap target of `44px` height (achieved via padding, not element resizing). Post-list title links get `padding: 0.25rem 0` to expand their tap area.

**Blockquotes:** `padding-left: 1rem` to save horizontal space.

**No hamburger menu at any breakpoint.** The nav has two links. They fit.

---

## 6. What Gets Removed from Millennial

Delete entirely:
- `_social-icons.scss` -- Font Awesome icon styles, social media colors, hover transitions. All gone.
- `_-sections-dir.scss` -- replaced by a clean single import structure.
- `featured-post.html` include -- featured post functionality does not exist in the new design.
- `post-share.html` include -- no share buttons.
- `related-posts.html` include -- no related posts section.
- `disqus.html` include -- no comments.
- `google-analytics.html` include -- add back later if wanted, but not part of the design.
- Font Awesome CSS/font references in `head.html` -- no icon font.
- All images in `assets/img/` that are post hero images (`welcome.jpg`, `learning.jpg`, `flower.jpg`, `start.jpg`, `chatgpt.jpg`, `pi.jpg`, `python_special_methods.jpg`). Keep `tbb.gif`, `tbb.mp4`, `val_batch2_pred.jpg`, `motion_controller_skeleton.png` (referenced in post body content). Keep PDF certificates.
- The dropdown menu system (`.dropdown`, `.dropbtn`, `.dropdown-content` and related JS in `header.html`).
- Fixed header behavior (`position: fixed`, `box-shadow`, `$header-thickness` offset).
- `$container-width: 1100px` and all references. The content column is 640px, not 1100px.
- `$brand-color: black` variable. Replace with the explicit color tokens above.
- Roboto font. Gone entirely.
- Source Code Pro font. Replaced by IBM Plex Mono.
- All social media color variables (`$envelope-color`, `$twitter-color`, etc.).
- `$icon-transition-time` variable.
- `.related`, `.related-posts`, `.related-thumbnail`, `.related-title` styles.
- `.post-share`, `.sharing-icons` styles.
- `.featured-image` styles.
- Pagination button border styling (`.pagination-button`). Replace with the simpler text-link pagination described above.
- Gist embed styles (`.gist` rules in `_code.scss`).
- `millennial.gemspec` -- the theme gem spec is not needed for a custom build.

Strip from layouts but keep the file:
- `post.html`: remove featured-image block, post-share include, disqus include, related-posts include. Keep title, date, content, post-navigation.
- `home.html`: remove featured-post include, post-card excerpts, post-card images. Rebuild as the date/title list.
- `default.html`: remove Font Awesome link, remove any theme-specific meta. Keep structure.
- `head.html`: replace Roboto Google Fonts link with the Source Serif 4 + IBM Plex Mono link above. Remove Font Awesome.
