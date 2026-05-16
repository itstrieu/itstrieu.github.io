# Redesign Directions

Three options. One recommendation.

---

## Direction 1: "The Long Read"

**Serif-first reading experience built around the prose, nothing else.**

**Feeling:** Opening a well-typeset essay in a literary journal. Quiet authority. The design tells you this is worth your time before you read a word.

**Typography:**
- Body: Source Serif 4, 18px/1.75, weight 400. Google Fonts.
- Headings: Source Serif 4, weight 600, -0.02em tracking. h1 at 1.75rem, h2 at 1.35rem.
- Code: JetBrains Mono, 14px/1.5, weight 400.
- Meta (dates, nav labels): DM Mono, 13px, weight 400, 0.05em tracking, uppercase.

**Color:**
- Text: `#1a1a1a` on `#fafaf8` (warm near-white)
- Secondary text: `#6b6b6b` (passes AA at 4.7:1)
- Links: `#1a1a1a` with 1px underline offset 3px, underline color `#c8c4bc`
- Accent (hover, active): `#b8965a` (Aeterna gold -- subtle family tie)
- Rules/dividers: `#ddd8d0`
- Code background: `#f4f2ee`

**Layout:**
- Max-width 620px content column, centered. No sidebar. No visible container.
- 20px horizontal padding at all sizes; 16px below 480px.
- Home page: date left-aligned in DM Mono, title below, no excerpt. One post per entry. Vertical list with 2.5rem spacing and a 1px rule between entries.
- Post page: title, date, then content. No hero. Section breaks (`<hr>`) rendered as 48px of vertical space with no visible line -- just breath.
- Nav: site name top-left ("it's trieu" in DM Mono, lowercase, tracked), About link top-right. No hamburger needed -- there are only two links. On mobile, both fit on one line.
- Footer: just the tagline in secondary text. GitHub and LinkedIn as text links, not icons.

**Why it fits her:** The serif says "I wrote this carefully." The monospace metadata borrows from Aeterna's design language without copying it. No images means the typography has to carry everything -- Source Serif 4 is designed for exactly that. The warm background softens long reads without feeling "cozy blog." The gold accent creates a thread between the personal blog and the consulting practice without making them look like the same brand.

**Reference:** [Gwern.net](https://gwern.net) for the reading-first philosophy, but warmer and less dense. Think gwern crossed with Craig Mod's essays.

**Stack:** Move to Astro. Markdown-native, zero JS by default, deploys to GitHub Pages. Jekyll works but Astro's content collections handle frontmatter, tags, and future "start here" paths more cleanly. The migration is mechanical -- same markdown files, new templates.

---

## Direction 2: "The Notebook"

**Monospace-forward, developer-personal aesthetic. Structured but not sterile.**

**Feeling:** Reading someone's well-kept field notes. Technical credibility on the surface, personal depth underneath.

**Typography:**
- Body: IBM Plex Sans, 16px/1.7, weight 400.
- Headings: IBM Plex Sans, weight 600. h1 at 1.6rem, h2 at 1.25rem.
- Code + meta: IBM Plex Mono, 14px/1.5.
- Pull quotes / section epigraphs: IBM Plex Sans Italic, 17px.

**Color:**
- Text: `#1c1c1c` on `#ffffff`
- Secondary: `#666666`
- Links: `#2563eb` (one blue, used consistently)
- Code background: `#f6f6f6`
- Borders/rules: `#e5e5e5`

**Layout:**
- Max-width 660px, centered.
- Home page: post list as a simple table -- date in mono on the left, title on the right. Dense, scannable. Inspired by Dan Luu's blog but with better type.
- Post page: title at top, date below in mono, content. Section breaks as a centered `* * *` in secondary text with 40px vertical margin.
- Nav: minimal top bar. Site name left, About right. Flat, no shadow, no fixed position -- scrolls with page.
- Footer: links to GitHub, LinkedIn, RSS. Plain text.

**Why it fits her:** The Plex family is the IBM typeface -- signals engineering credibility without the cliche of system monospace everywhere. The blue link color is the only chromatic element, which makes it feel intentional rather than decorated. The table-style home page says "here is what I wrote, pick one" -- no sell, no excerpts, no thumbnails. This is the design for someone who wants the writing to do all the work.

**Reference:** [danluu.com](https://danluu.com) for the anti-design confidence, but with actual typographic care applied.

**Stack:** Stay on Jekyll. This direction is simple enough that Jekyll handles it fine. Fewer moving parts.

---

## Direction 3: "The Imprint"

**Warm editorial design with Aeterna's DNA. The blog as a personal publication, not a feed.**

**Feeling:** A small-press journal. Something you'd read in a leather chair. Authoritative but human.

**Typography:**
- Body: Cormorant Garamond, 19px/1.8, weight 400. Same as Aeterna-web.
- Headings: Cormorant Garamond, weight 600, -0.02em. h1 at 2rem, h2 at 1.4rem.
- Code: DM Mono, 13.5px/1.5.
- Meta/labels: DM Mono, 12px, 0.12em tracking, uppercase.

**Color:**
- Text: `#0e0e0e` on `#f5f2ec` (Aeterna's ink-on-paper, directly)
- Secondary: `#7a7570` (Aeterna's --muted)
- Links: `#0e0e0e`, underline in `#b8965a` (gold underline, ink text)
- Rules: `#d8d2c8` (Aeterna's --rule)
- Code background: `#edeae4`
- Accent: `#b8965a` (Aeterna gold, used sparingly -- hover states, the site name)

**Layout:**
- Max-width 600px, centered on a full `#f5f2ec` background.
- Home page: each post as title + date. Generous vertical spacing (3rem). No excerpts. A thin gold rule separates entries.
- Post page: title in Cormorant at 2rem, date below in DM Mono uppercase, then content. Section breaks as a centered gold `---` (1px solid gold, max-width 80px, 56px vertical margin).
- Nav: "it's trieu" in DM Mono tracked uppercase, top-left. About link top-right. No fixed header. Scrolls with content.
- Footer: tagline in DM Mono. Links to GitHub and LinkedIn as text.

**Why it fits her:** This is the Aeterna aesthetic applied to a personal space. Cormorant Garamond at reading sizes is gorgeous for long-form prose -- it was designed for editorial work. The gold accent creates a clear visual thread: if someone visits the blog and then Aeterna's site, the family resemblance is immediate. It signals that the same person built both, that the craft is consistent.

**Reference:** [craigmod.com](https://craigmod.com) for the editorial warmth and attention to reading experience.

**Stack:** Astro. Same reasoning as Direction 1 -- content collections, zero JS default, GitHub Pages deployment. The Cormorant + DM Mono pairing is already loaded in Aeterna-web, so there's visual infrastructure overlap.

---

## My recommendation: Direction 1, "The Long Read."

Direction 3 is tempting because the Aeterna connection is elegant. But the blog is personal. It predates Aeterna. It contains vulnerability, career doubt, and identity searching that would feel strange wrapped in a consulting brand's visual language. The blog needs its own identity that *rhymes* with Aeterna without being a subsidiary of it.

Direction 2 is clean and honest but undersells the writing. Dan Luu's anti-design works because his content is purely technical. Kathy's strongest piece is a 2000-word personal essay about shame and identity. That deserves typographic warmth, not IBM Plex on white.

Direction 1 gives her both. Source Serif 4 is serious enough for the technical posts and warm enough for the personal ones. The DM Mono metadata creates the Aeterna rhyme without importing the full palette. The gold accent is the single thread connecting the two -- visible if you know to look, invisible if you don't. And the warm near-white background (`#fafaf8`) distinguishes the blog from Aeterna's `#f5f2ec` while staying in the same temperature.

The no-image constraint actually makes Direction 1 stronger. When there are no images, the serif typeface becomes the entire visual identity. Source Serif 4 at 18px on a 620px measure is a reading experience that justifies itself. The writing is good enough to carry it.

Move to Astro. The migration is a weekend. The payoff is a cleaner authoring experience, faster builds, and a foundation that handles the "start here" path and future tag-based navigation the positioning audit called for.
