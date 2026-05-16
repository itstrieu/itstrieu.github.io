# UX Audit — itstrieu.github.io

Audited: 2026-05-15
Auditor: UI/UX Designer agent
Scope: Full reading experience — typography, layout, color, mobile, navigation

---

## 1. Typography

### Current state

| Property | Current value | Source |
|---|---|---|
| Base font family | `'Roboto', sans-serif` | `$base-font-family` in main.scss |
| Body font family | `'Roboto', sans-serif` | `$body-font-family` in main.scss |
| Code font family | `"Source Code Pro", monospace` | `$code-font-family` in main.scss |
| Base font size | Browser default (16px) — never explicitly set | _base.scss, body rule |
| Body line-height | `1.65` on `p` elements only | _base.scss |
| Heading line-height | `1.25` | _base.scss |
| Letter-spacing | Not set anywhere | — |
| h1 size | `2rem` (32px) | _base.scss |
| h2 size | `1.5rem` (24px) | _base.scss |
| h3 size | `1.25rem` (20px) | _base.scss |
| h4-h6 size | `1rem` (16px) | _base.scss |
| Code size | `0.8rem` (12.8px) | _code.scss |
| Post date size | `0.8rem` (12.8px) | _post.scss |

### Assessment

**What works:**
- Roboto is a clean, readable sans-serif. It is fine as a workhorse font.
- `line-height: 1.65` on paragraphs is decent for body text.
- Source Code Pro is a good code font choice.

**What needs changing:**

1. **No font-size set on `body` or `html`.** The entire type scale floats on the browser default. This is technically fine but means there is no intentional baseline. Setting an explicit base gives control over the entire rem cascade.

2. **`line-height: 1.65` is only on `p`.** Headings get `1.25`, but `body` has no line-height at all. List items, blockquotes, and other elements inherit the browser default (usually ~1.2). This creates inconsistent vertical rhythm.

3. **No letter-spacing anywhere.** Roboto at body sizes reads fine without it, but headings (especially the h1 post title at 32px) would benefit from slight negative tracking to feel tighter and more intentional.

4. **Heading scale is compressed.** h1=32px, h2=24px, h3=20px, h4=16px. The jump from h3 to h4 collapses to nothing — h4 is the same as body text. And h2 (used as section headings in posts) doesn't assert enough authority.

5. **`0.8rem` (12.8px) for code and post dates is too small.** At that size, Source Code Pro becomes hard to scan, especially in the longer code blocks (like the MotionController class in the tennis ball post). The date at 12.8px feels like an afterthought rather than useful metadata.

6. **Font weight is only `bold` or default.** There is no use of `font-weight: 600` or `500` anywhere except the home page post card h2 (`font-weight: 600`). The heading weight should be calibrated per level.

7. **Roboto is loaded from Google Fonts but without weight variants.** The current `<link>` loads the default (400) weight. Bold uses the browser's faux-bold. Loading `400` and `700` explicitly (or even `400;500;700`) would produce cleaner rendering.

---

## 2. Measure (Line Length)

### Current state

| Context | Width | Approx. characters per line |
|---|---|---|
| Post content (desktop) | `600px` fixed | ~80-90 characters |
| Post content (< 1100px) | `60vw` | Varies: ~55-75 chars at 900px, grows beyond at larger |
| Post content (< 600px) | `95vw` | ~40-50 chars on phone |
| Container | `1100px` fixed | N/A (post sits centered inside) |

### Assessment

**The 600px fixed post width is the right neighborhood but slightly too wide.** At 600px with Roboto at 16px, a typical paragraph line runs 80-90 characters. The comfortable range for sustained reading is 45-75 characters (Bringhurst). This means desktop readers are getting lines ~15 characters too long.

**The 60vw breakpoint is reasonable** for tablets but imprecise — at exactly 1099px viewport, 60vw = 659px (wider than the desktop fixed width).

**At 95vw on mobile, the measure collapses to ~40-50 chars** depending on device. This is acceptable but the padding is only the implicit margin from the 5vw remaining. No horizontal padding is set on `.post-content` itself, so text runs right to the screen edge on narrow devices.

---

## 3. Whitespace

### Current state

| Element | Spacing | Source |
|---|---|---|
| Content top padding | `$header-thickness + 10px` = `66px` | _default.scss |
| Post content margin | `10px auto 10px` | _post.scss |
| Paragraph spacing | `margin-top: 1em; margin-bottom: 1em` | _base.scss |
| h1 margin-bottom | `0.5rem` (8px) | _base.scss |
| h2 margin-top | `1rem` (16px) | _base.scss |
| h3 margin-top | `1.5rem` (24px) | _base.scss |
| Post date margin | `margin-bottom: 1rem` | _post.scss |
| Section rule (hr/---) | `margin: 0; padding: 0` (reset, never re-styled) | _base.scss reset |
| Blockquote margin | `10px 20px 10px` | _base.scss |
| List margin | `1rem top/bottom, 1.5rem left` | _base.scss |
| List item margin | `1rem bottom` (plus `1rem top/bottom` on `ol li`) | _base.scss |
| Post card padding | `2rem 10px` | _home.scss |

### Assessment

**Critical issue: `<hr>` is completely unstyled.** The reset sets `margin: 0; padding: 0` on `hr`, and nothing restores it. In the long-form posts (like "Why I Call Myself an AI Systems Builder"), the `---` section breaks are the primary structural device. They create the rhythm of the piece. Right now they render as a thin line with zero vertical breathing room — the exact opposite of what the content needs.

**Heading spacing is inverted.** h2 gets only `1rem` top margin while h3 gets `1.5rem`. The more important heading should have more space above it, not less.

**Paragraph spacing at `1em` top AND bottom creates 2em (32px) between paragraphs.** This is generous, which works for the reflective prose style. But it means the gap between the last paragraph of a section and the `---` separator (which has 0 margin) is jarring — the text bumps right into the rule.

**Post title to date to body has cramped rhythm.** The h1 has `margin-bottom: 0.5rem` (8px), the date has `margin-bottom: 1rem` (16px), then the first paragraph starts. The title needs more room beneath it to settle.

**10px top/bottom margin on `.post-content` is negligible.** The post content sits 10px below the content-wrapper's padding and 10px above the share/related section. The bottom of the post needs more terminal whitespace.

---

## 4. Color Palette

### Current state

| Element | Color | Hex |
|---|---|---|
| Brand color (links, header text) | Black | `#000000` ($brand-color) |
| Body text | Browser default black | `#000000` (inherited) |
| Background | White | `#ffffff` (no explicit set — browser default) |
| Post date | Gray | `#9a9a9a` |
| Footer description | Gray | `#9a9a9a` |
| Blockquote text | Gray | `#999` |
| Blockquote border | Light gray | `#ccc` |
| Post card excerpt | Gray | `#666` |
| Post card meta | Gray | `#999` |
| Post card hover | Dark gray | `#555` |
| Post card divider | Light gray | `#e0e0e0` |
| Code background | Near-white | `#f5f5f5` |
| Table border | Black | `#000000` |
| Dropdown background | Near-white | `#f9f9f9` |
| Header shadow | Gray | `#bbb` (via box-shadow) |

### Assessment

**The palette is essentially black, white, and three grays (#999, #666, #e0e0e0).** This is fine for the "quiet confidence" principle. But:

1. **Links are pure black with no underline (in body) / underline (in container).** The `a` tag gets `color: $brand-color` (black) and `text-decoration: none` in _base.scss, but `.container a` adds `text-decoration: underline` in _default.scss. This means in-post links are underlined black text on white — they look like bold text at a glance. There is no color distinction for links. This is an accessibility concern (WCAG requires links to be distinguishable by more than underline alone if the surrounding text is the same color, unless the contrast ratio between link and surrounding text is at least 3:1).

2. **Blockquote text at `#999` on `#fff` fails WCAG AA contrast.** The ratio is approximately 2.85:1 (AA requires 4.5:1 for normal text). The Learning Log post uses a blockquote for a ChatGPT quote — it is hard to read.

3. **Post date at `#9a9a9a` also fails AA contrast** at approximately 2.82:1.

4. **Post card meta at `#999` fails AA.** Same issue.

5. **No background color is explicitly set on `body`.** If the browser or OS uses a different default, the contrast assumptions break.

6. **Table borders are pure black (`1px solid black`).** This is harsh. The tables in the content don't need maximum contrast borders.

---

## 5. Mobile Experience

### Current state

**Breakpoints:**

| Breakpoint | Variable | Behavior |
|---|---|---|
| `1100px` | `$container-width` | Primary breakpoint — triggers responsive layout |
| `600px` | `$tablet-width` | Post content switches to `95vw` |
| `480px` | `$phone-width` | Defined but never used |

**Mobile header:** At < 1100px, the nav menu hides and a dropdown hamburger (`.dropbtn`) appears using CSS `:hover`. Social icons are in the dropdown.

**Mobile post width:** At < 600px, post content is `95vw` — nearly full-bleed with only 2.5vw margin on each side.

### Assessment

1. **The hover-based dropdown does not work on touch devices.** The mobile menu relies entirely on `.dropdown:hover .dropdown-content { display: block; }`. On iOS and most Android browsers, `:hover` fires inconsistently on tap. This means mobile users may have difficulty accessing the About, Contact, and social links. This is the single most critical functional bug in the current design.

2. **Only two real breakpoints.** The jump from 1100px straight to 600px leaves tablets (768px-1100px) in the `60vw` post width zone. At 768px, 60vw = 461px, which is actually fine. But the container itself is `95vw` at this point while the post content is `60vw` — creating wide gutters that look unintentional.

3. **`$phone-width: 480px` is defined but never referenced.** No styles target this breakpoint. Narrow phones (< 400px logical) get no special treatment.

4. **No horizontal padding on `.post-content` at mobile sizes.** At 95vw, the 2.5vw margin on each side is ~9px on a 375px phone. Text sits uncomfortably close to screen edges. Standard practice is 16-20px of horizontal padding.

5. **The fixed header at mobile widths (`width: 95vw`) doesn't span the full viewport.** The remaining 5vw creates a visual gap. On mobile, a fixed header should be `width: 100%`.

6. **Images have `max-width: 600px` (desktop) and `max-width: 60vw / 95vw` at breakpoints.** But the `body img` rule has `max-width: 600px` which can cause images to overflow on narrow containers between breakpoints.

7. **Font Awesome 4.6.3 is loaded.** This is a legacy version (current is 6.x). The hamburger icon works, but the full 4.6.3 CSS file is ~30KB for what amounts to 4-5 icons. On mobile connections, this is unnecessary weight.

8. **MathJax is loaded on every page** (in head.html) even though only some posts might use math. This is a heavy library (~170KB+ for the config). On mobile, it adds noticeable load time for no benefit on non-math pages.

---

## 6. Reading Experience

### Section breaks (hr/---)

**Current:** The `---` in markdown produces `<hr>` tags. These are reset to `margin: 0; padding: 0` and never re-styled. They render as a default browser hairline. In "Why I Call Myself an AI Systems Builder," there are six section breaks that create the emotional rhythm of the piece. Right now they appear as thin gray lines crammed between paragraphs with no breathing room.

**Needed:** The `<hr>` is the most important typographic element in the long-form posts. It needs generous vertical spacing and a considered visual treatment.

### Blockquotes

**Current:** `margin: 10px 20px 10px`, `padding: 0px 15px`, `border-left: 0.25em solid #ccc`, `color: #999`, `line-height: 1.5`. The text color fails contrast. The margins are in `px` while everything else uses `rem/em`. The line-height drops from the body's 1.65 to 1.5.

**Needed:** Blockquotes are used for pull quotes and citations. They should feel set apart but still be readable.

### Bold and italic

**Current:** Bold (`<strong>`) uses browser default bold. Italic (`<em>`) uses browser default italic. No custom styling.

**Assessment:** This is fine. The posts use bold effectively for emphasis ("That is not what I do." / "Then I watched the ground shift..."). The default rendering serves the content. No changes needed to bold/italic styling.

### Code blocks

**Current:** `font-size: 0.8rem` (12.8px), `line-height: 1.4`, `background: #f5f5f5`, `padding: 1rem`, `border-radius: 4px` (on `.highlight` only, not on `pre` itself). Inline code gets `padding: .25em .5em`, same background, `border-radius: 3px`.

**Assessment:** The tennis ball bot post has significant code blocks (40+ lines). At 12.8px, this code is small enough to strain. The `pre` element has `white-space: pre-wrap` and `word-break: break-all` which can break code in odd places. For a 600px content width, code blocks will need horizontal scrolling anyway for long lines — `pre-wrap` with `break-all` is worse than overflow-x scrolling. Code block has no border-radius on `pre` but `.highlight` gets 4px — inconsistent.

### Lists

**Current:** `margin-left: 1.5rem`, each `li` has `margin-bottom: 1rem`. The Learning Log post is heavily list-based (reading, taking, building, practicing sections). The 1rem gap between items is generous — it makes the lists feel like they breathe, which suits the content. But `ol li` gets additional `margin-top: 1rem` AND `margin-left: 1.5rem` on top of the `ul/ol` left margin, creating double-indentation for ordered lists.

---

## 7. Navigation

### Header

**Current:** Fixed position, 56px tall, white background, subtle `box-shadow: 0 5px 6px -6px #bbb`. Site title ("it's trieu") as h3 with `font-size: 26px`, `font-weight: 400`. Menu links: About, Contact, plus GitHub, LinkedIn, RSS icons. On mobile: hamburger dropdown via CSS `:hover`.

**Assessment:**

1. The fixed header is appropriate — it keeps navigation accessible during long reads. But 56px of vertical space permanently consumed on mobile (where viewport height is precious) is a consideration. At minimum, the header should not feel heavy.

2. The site title at `font-weight: 400` feels too light for a brand identifier. It reads almost like body text in the nav bar.

3. "About" and "Contact" are reasonable navigation items. The social icons in the header are fine but could live in the footer only to reduce visual weight.

4. The header `width: $container-width` (1100px) doesn't account for viewports wider than 1100px. On a 1440px screen, the header floats left with white space to the right. Same for the footer and container. The site is not truly centered on wide screens.

5. The `box-shadow` is subtle and works. No change needed there.

### Footer

**Current:** Social icons (GitHub, LinkedIn, RSS) + description line: "it's trieu | building things, figuring things out by Kathy Trieu" at `0.8rem` in `#9a9a9a`.

**Assessment:** The footer is minimal. The description text at 12.8px in low-contrast gray is barely legible. The footer lacks any post-to-post navigation. After reading a long post, the reader's only option is the browser back button or the "You may also enjoy..." related posts section (which depends on tag matching and may show nothing).

### Post navigation

**Current:** Share buttons (Twitter/Facebook) with the prompt "Feel free to share!" followed by "You may also enjoy..." related posts. No previous/next post links.

**Assessment:**

1. "Feel free to share!" is filler copy that doesn't match the voice. The exclamation point explicitly violates the "no exclamation points" principle.
2. The Twitter/Facebook share buttons use Font Awesome icons with no labels. Twitter's icon may be outdated (the platform is now X). Facebook sharing feels off-brand for this type of content.
3. Related posts depend on tag matching. The tags on some posts are fragmented (the Tennis Ball Bot post has `Machine`, `Learning` as separate tags instead of `Machine Learning`). This will produce unreliable related post suggestions.
4. No previous/next post navigation means the reader has no linear path through the blog.

### Home page

**Current:** Paginated list of posts as `.post-card` items. Title (h2, 1.4rem, weight 600), description excerpt, date. Clean card layout with `border-bottom: 1px solid #e0e0e0`.

**Assessment:** The home page cards are the most refined part of the current design. The hierarchy is clear: title, excerpt, date. The sizing and spacing work. Minor issues: the pagination labels "Newer" and "Older" are reversed in the template (the `next_page` path gets the "Older" label via `previous_page` setting string). This may be intentional for reverse-chronological ordering, but it's worth verifying.

---

## 8. Specific Recommendations

Prioritized by impact on reading experience. Each spec is ready for the Front-End Dev to implement.

### P0 — Critical (fix immediately)

#### 8.1 Style the `<hr>` section break

The most impactful single change for reading experience.

```scss
// _base.scss — replace the hr reset with:
hr {
  border: none;
  border-top: 1px solid #e0e0e0;
  margin: 3rem auto;
  width: 100%;
}
```

Rationale: 3rem (48px) of breathing room above and below. Subtle line that matches the post-card divider color. This alone transforms the reading rhythm of the long-form posts.

#### 8.2 Fix mobile navigation

Replace CSS `:hover` dropdown with a click/tap-based toggle. This requires minimal JavaScript.

```html
<!-- In header.html, add onclick to the dropbtn -->
<button class="dropbtn" onclick="this.parentElement.classList.toggle('open')">
  <i class="fa fa-bars" aria-hidden="true"></i>
</button>
```

```scss
// _header.scss — replace the hover rule:
// Remove: .dropdown:hover .dropdown-content { display: block; }
// Remove: .dropdown:hover .dropbtn { background-color: #f1f1f1; }
// Add:
.dropdown.open .dropdown-content {
  display: block;
}
.dropdown.open .dropbtn {
  background-color: #f1f1f1;
}
```

Rationale: The current menu is broken on all touch devices. This is a functional bug, not a style preference.

#### 8.3 Fix contrast failures

```scss
// _base.scss — blockquote
blockquote {
  color: #595959;  // contrast ratio ~7:1 against #fff
}

// _post.scss — post date
.post-date {
  color: #717171;  // contrast ratio ~4.6:1, passes AA
}

// _home.scss — post meta
.post-card .post-meta {
  color: #717171;  // same
}

// _footer.scss — footer description
.footer-description {
  color: #717171;
}
```

Rationale: Current `#999` and `#9a9a9a` values fail WCAG AA (4.5:1 minimum for normal text). The replacement `#717171` achieves ~4.6:1 while still reading as secondary text. Blockquote at `#595959` gets ~7:1 because it carries actual content.

### P1 — High (significantly improves reading experience)

#### 8.4 Set explicit base typography

```scss
// _base.scss — add to body rule:
body {
  font-family: $base-font-family;
  font-size: 1.0625rem;       // 17px — slightly above browser default
  line-height: 1.7;           // applies globally, not just to p
  color: #1a1a1a;             // softer than pure black, reduces glare
  background-color: #ffffff;  // explicit, not assumed
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
```

And update `p` to remove the redundant line-height:

```scss
p {
  display: block;
  margin-top: 1em;
  margin-bottom: 1em;
  margin-left: 0;
  margin-right: 0;
  // Remove: line-height: 1.65;  (now inherited from body at 1.7)
  font-family: $body-font-family;
}
```

Rationale: 17px base is the sweet spot for long-form reading on screens. `1.7` line-height gives slightly more air than the current `1.65` on paragraphs and fixes the missing line-height on all other elements. `#1a1a1a` body text reduces the harshness of pure black on white — an effect that's subtle but measurable in reading comfort over long sessions.

#### 8.5 Load Roboto with explicit weights

```html
<!-- In head.html, replace the Google Fonts link: -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,400;0,500;0,700;1,400;1,700&display=swap">
```

Rationale: Loading 400, 500, 700, and their italic variants gives the browser real weight data instead of synthesizing bold/italic. `display=swap` prevents FOIT (flash of invisible text).

#### 8.6 Reduce post content width and add horizontal padding

```scss
// _post.scss
.post-content {
  max-width: 640px;    // changed from fixed 600px to max-width
  width: 100%;         // fluid within max-width
  display: block;
  margin: 0 auto;
  padding: 0 1.25rem;  // 20px horizontal padding at all sizes
  box-sizing: border-box;
}

// Remove the tablet media query override to 60vw — the max-width + padding handles it.
// Keep the mobile override but simplify:
@media (max-width: $tablet-width) {
  .post-content {
    max-width: 100%;
    padding: 0 1rem;   // 16px on small phones
  }
}
```

With Roboto at 17px and 640px max-width (minus 40px padding = 600px text width), this yields approximately 70-75 characters per line. Adding the slight font size increase brings the measure into the 65-72 range — within the comfortable zone.

#### 8.7 Rework heading scale and spacing

```scss
// _base.scss
h1 {
  font-size: 1.75rem;     // 29.75px — tighter than current 2rem
  font-weight: 700;
  letter-spacing: -0.02em;
  margin-bottom: 0.75rem;
}
h2 {
  margin-top: 2.5rem;     // was 1rem — much more breathing room
  font-size: 1.375rem;    // 23.375px
  font-weight: 700;
  letter-spacing: -0.01em;
  margin-bottom: 0.75rem;
}
h3 {
  margin-top: 2rem;       // was 1.5rem
  font-size: 1.125rem;    // 19.125px
  font-weight: 600;       // medium-bold, distinguishes from h2
  margin-bottom: 0.5rem;
}
h4, h5, h6 {
  margin-top: 1.5rem;
  font-size: 1rem;
  font-weight: 600;
}
```

Rationale: The heading margin-top progression now correctly scales with importance: h2 gets the most space (2.5rem) because it introduces major sections. Negative letter-spacing on h1/h2 tightens the heading text for a more deliberate feel. h3 at weight 600 distinguishes it from h2 at 700.

#### 8.8 Restyle blockquotes

```scss
blockquote {
  margin: 1.5rem 0;
  padding: 0 0 0 1.25rem;
  border-left: 3px solid #d0d0d0;
  color: #595959;
  line-height: 1.7;       // match body
  font-style: italic;
}
blockquote p {
  margin-top: 0.5em;
  margin-bottom: 0.5em;
}
```

Rationale: Left-aligned with body text (no right indent). Border slightly thicker (3px vs 4px/0.25em) and lighter gray. Italic distinguishes the quote from surrounding prose. Inner paragraph margins tightened so multi-paragraph quotes feel cohesive.

### P2 — Medium (polish and consistency)

#### 8.9 Improve code blocks

```scss
code,
pre {
  font-family: $code-font-family;
}
code {
  padding: .2em .4em;
  font-size: 0.875rem;        // 14.875px — up from 12.8px
  background-color: #f5f5f5;
  border-radius: 3px;
}
pre {
  display: block;
  margin-top: 1.5rem;
  margin-bottom: 1.5rem;
  padding: 1.25rem;
  font-size: 0.8125rem;       // 13.8px — up from 12.8px
  line-height: 1.5;           // up from 1.4
  overflow-x: auto;           // horizontal scroll instead of word-break
  white-space: pre;           // remove pre-wrap
  // Remove: word-break: break-all;
  // Remove: word-wrap: break-word;
  background-color: #f5f5f5;
  border-radius: 4px;
}
```

Rationale: Code blocks should scroll horizontally rather than break lines arbitrarily. The font size increase from 12.8px to ~14px makes code actually readable. The tennis ball bot post has 40+ line code blocks that benefit from this.

#### 8.10 Add post title area spacing

```scss
// _post.scss — add
.post-content h1 {
  margin-bottom: 0.25rem;
}
.post-content .post-date {
  margin-bottom: 2rem;        // was 1rem — more space before body begins
}
```

Rationale: The post title and date form a header unit. More space between the date and the first paragraph signals "the piece begins here."

#### 8.11 Fix mobile header to full width

```scss
@media (max-width: $container-width) {
  .site-header {
    width: 100%;              // was 95vw
    left: 0;                  // ensure it spans viewport
    box-sizing: border-box;
    padding: 0 2.5vw;         // maintains the inner alignment
  }
}
```

#### 8.12 Improve table styling

```scss
table, th, td {
  border: 1px solid #d0d0d0;  // was black
}
th {
  background-color: #f9f9f9;
  font-weight: 600;
}
th, td {
  padding: 0.75rem 1rem;      // was 15px
  text-align: left;
}
```

#### 8.13 Remove share buttons and update post footer

Remove the "Feel free to share!" section and Twitter/Facebook buttons. Replace with simple previous/next post navigation.

```html
<!-- In post.html, replace the post-share include with: -->
{% if page.previous.url %}
  <a class="post-nav-link post-nav-prev" href="{{ site.github.url }}{{ page.previous.url }}">
    &larr; {{ page.previous.title }}
  </a>
{% endif %}
{% if page.next.url %}
  <a class="post-nav-link post-nav-next" href="{{ site.github.url }}{{ page.next.url }}">
    {{ page.next.title }} &rarr;
  </a>
{% endif %}
```

```scss
// _post.scss — add
.post-nav-link {
  display: block;
  padding: 0.75rem 0;
  color: #1a1a1a;
  text-decoration: none;
  font-size: 0.9375rem;
  border-top: 1px solid #e0e0e0;
}
.post-nav-link:hover {
  color: #555;
}
.post-nav-next {
  text-align: right;
}
```

Rationale: "Feel free to share!" violates the voice. The Twitter/Facebook share icons are low-value. Previous/next navigation gives readers a path through the blog, which is what actually matters.

#### 8.14 Tighten ordered list double-indent

```scss
// _base.scss — remove the ol li rule that adds extra margin-left:
// Remove:
// ol li {
//   margin-top: 1rem;
//   margin-bottom: 1rem;
//   margin-left: 1.5rem;
// }

// The li rule already handles margin-bottom: 1rem.
// The ol rule already handles margin-left: 1.5rem.
```

### P3 — Low (future improvements)

#### 8.15 Consider lazy-loading MathJax

Move the MathJax `<script>` tag to a conditional include that only loads on posts that use math. Or add a `math: true` frontmatter flag.

#### 8.16 Upgrade Font Awesome

Replace Font Awesome 4.6.3 with a subset of icons (bars, github, linkedin, rss) loaded as SVGs or via Font Awesome 6 with tree-shaking. This would reduce the CSS payload from ~30KB to under 3KB.

#### 8.17 Consider a serif option for body text

Roboto is functional but generic. A serif like `'Source Serif 4'` or `'Libre Baskerville'` for body text (keeping Roboto for headings and UI) would better match the "unhurried, precise" voice. This is a taste call, not a bug — flagging it for consideration, not as a spec.

#### 8.18 Add `max-width: 100%` to all images

```scss
body img {
  display: block;
  margin: 1.5rem auto;
  max-width: 100%;            // responsive — never overflows container
  height: auto;
}
```

The current `max-width: 600px` on `body img` can overflow on narrow containers.

---

## Summary of priorities

| Priority | Items | Impact |
|---|---|---|
| P0 | 8.1 (hr spacing), 8.2 (mobile nav), 8.3 (contrast) | Fixes broken functionality and accessibility failures |
| P1 | 8.4-8.8 (typography, measure, headings, blockquotes) | Transforms the reading experience from generic to intentional |
| P2 | 8.9-8.14 (code, title spacing, mobile header, tables, post nav, lists) | Polish and consistency |
| P3 | 8.15-8.18 (performance, font exploration, images) | Future refinement |

The current design is functional but generic. The Millennial theme was a reasonable starting point, but it was designed for a photo-heavy lifestyle blog, not long-form reflective prose. The posts deserve typography and spacing that match the care in the writing. The changes above, especially P0 and P1, would bring the reading experience in line with the voice: precise, unhurried, with room to breathe.
