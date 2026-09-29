# ashscript : Static GitHub Pages Site

A GitHub Pages-ready static site for application packaging, endpoint automation, useful scripts, and a phase-based Microsoft Intune learning path.

## Site sections

- **Scripts** : searchable PowerShell, VBScript, Batch and HTA library.
- **Intune Tutorials** : nine phases covering Intune foundations through advanced endpoint management.
- **Who Am I** : author/profile page.

## Deploy to GitHub Pages

1. Create or open a GitHub repository.
2. Upload the project files.
3. In **Settings → Pages**, choose **Deploy from a branch**.
4. Select `main` and `/ (root)`.
5. Save.

No framework, package manager, Node.js or build step is required.

## Local testing

Because the script library and Intune curriculum are loaded with `fetch()`, test through a local HTTP server rather than opening the HTML files with `file://`.

```bash
python -m http.server 8000
```

Then open `http://localhost:8000/`.

## Useful Scripts library

The Useful Scripts page reads `assets/data/scripts.json` at runtime. To add another script:

1. Put the real source file in the appropriate `scripts/` directory.
2. Add one catalog object to `assets/data/scripts.json`.
3. Test the search, filters and detail-page link locally.

Each script opens through a clean URL such as `scripts/<slug>/`.

## Intune tutorial

The Intune curriculum index is available at the clean URL `intune/`. The phase/lesson catalog is stored in `assets/data/intune-tutorial.json`, so the navigation and lesson list can be updated without rewriting the page markup.

Each lesson links to its own clean URL under `intune/`, using a descriptive lesson slug. The individual lesson page is designed as the destination for the detailed lesson material.

The supplied ZIP did not contain the referenced PDF, so the phase and lesson structure is populated from the curriculum supplied with the request.

## Design direction

The visual system uses:

- near-black / graphite backgrounds
- acid-lime accent `#d9ff00`
- thin technical borders
- restrained neon glow
- compact uppercase labels
- high-contrast editorial headings
- responsive cards and navigation

## Pretty URLs and favicon

The site uses directory-based clean URLs compatible with static GitHub Pages hosting. Normal page URLs do not expose `.html`; for example, `intune/`, `who-am-i/`, and `scripts/<slug>/`. The supplied Ashpak “A” icon is used as the site favicon and app icon.

## Intune Phase 1 Lessons
Phase 1 lessons 1.1-1.5 are published under clean GitHub Pages URLs as native AshScript-themed HTML. The supplied lesson wording, tables, diagrams and flow charts are represented as web content and custom scalable SVG diagrams rather than PDF page screenshots.


## Intune curriculum status

Phase 3 : Enrolling Devices is now live with lessons 3.1-3.7. Lesson pages use clean GitHub Pages URLs and native AshScript-styled content, diagrams, tables, and lesson navigation.


## Intune tutorial status

Phases 6, 7, and 8 now include the supplied lesson material for Lessons 6.1-6.7, 7.1-7.5, and 8.1-8.5. The remaining curriculum lessons stay marked as planned until their source material is provided. Lesson content is rendered as native AshScript HTML with themed code/diagram cards and responsive tables; source PDFs are not required for the published pages.


## Visual refinement pass
The lesson reader uses grouped reference cards for bullet lists, a three-stage story navigation, lemon monospace URL links, full-width table section rows, and modern flow diagrams. The lesson pages do not expose source PDFs as the primary reading experience.

### Local preview
```powershell
python -m http.server 8000
```
Open `http://127.0.0.1:8000/`.


## UI refresh: 2026-09-27
This build applies the supplied UI/UX change specification globally across the lesson readers: Learning Modules navigation, grouped reference lists, story-path navigation, complete table layouts, lemon URL treatment, spacing refinement, modern diagram boards, and removal of Concept Check/later wrap-up sections.
