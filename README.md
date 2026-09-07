# ashscript — Premium Static Learning Site

A GitHub Pages-ready static site for:

- Learn Application Packaging
- Learn Azure AI
- Learn SCCM / MECM
- Learn Intune
- Useful Scripts
- Blog
- Who Am I

## Deploy to GitHub Pages

1. Create a repository.
2. Upload this project (all files).
3. In **Settings → Pages**, choose **Deploy from a branch**.
4. Select `main` and `/ (root)`.
5. Save.

No framework, package manager, Node.js or build step is required.

## Personalize

### Photo
Replace the placeholder with:
`assets/images/profile.jpg`

Then the `Who Am I` page can use your actual photo.

### Your details
Edit `who-am-i.html` and replace the sample role/focus text with your biography, certifications, LinkedIn, GitHub and contact details.

### New learning pages
Duplicate any `learn-*.html` file, update its content, and add the new link to the navigation.

The expandable concept maps are SVG images in:
`assets/diagrams/`

### New blog posts
1. Copy `blog/post-02.html`.
2. Rename the file.
3. Update the title/date/content.
4. Add a card to `blog/index.html`.

### New packaging runbooks
Duplicate one of the files in `how-to/` and link it from `how-to.html`.

## Design direction

The visual system is inspired by the provided reference image:

- near-black / graphite backgrounds
- acid-lime accent `#d9ff00`
- thin technical borders
- neon glow used sparingly
- compact uppercase labels
- high-contrast editorial headings
- responsive cards and navigation


## Azure AI concept structure

The **Learn → Azure AI** page is now a concept library. Each card opens a dedicated tutorial page under:

`learn/azure-ai/`

Concept pages use the same article pattern as the rest of the site and include expandable visual concept maps.

## Profile photo

Your supplied photograph is now included as:

`assets/images/profile.jpg`

The **Who Am I** page references this image directly.


## Learn track structure

All four learning modules now use the same card-based concept library:
- Application Packaging
- Azure AI
- SCCM / MECM
- Intune

Each track can be expanded by adding more concept cards and article pages under `learn/<track>/`.


## Data-driven Useful Scripts library

The Useful Scripts page reads `assets/data/scripts.json` at runtime. To add another script:

1. Put the real source file in `scripts/powershell/`, `scripts/vbscript/`, `scripts/batch/` or `scripts/hta-vbscript/`.
2. Add one object to `assets/data/scripts.json` with `title`, `language`, `category`, `description`, `tags`, `body`, `slug` and `source`.
3. Test locally using `python -m http.server 8000`.

No HTML card needs to be created manually. The search, filters and detail page are driven from the JSON catalog.
