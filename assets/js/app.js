(() => {
  const toggle = document.querySelector('[data-menu-toggle]');
  const nav = document.querySelector('[data-nav]');

  const closeMobileNav = () => {
    if (!nav || !toggle) return;
    nav.classList.remove('open');
    toggle.setAttribute('aria-expanded', 'false');
  };

  const closeDropdowns = () => {
    document.querySelectorAll('.nav-links details[open]').forEach((details) => details.removeAttribute('open'));
  };

  if (toggle && nav) {
    toggle.addEventListener('click', () => {
      const isOpen = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', String(isOpen));
    });
  }

  document.querySelectorAll('.nav-links a').forEach((link) => {
    link.addEventListener('click', () => {
      closeMobileNav();
      closeDropdowns();
    });
  });

  document.addEventListener('click', (event) => {
    if (!event.target.closest('.nav-links') && !event.target.closest('.menu-toggle')) closeDropdowns();
  });

  document.querySelectorAll('.lesson-toc a[href^="#"]').forEach((link) => {
    link.addEventListener('click', (event) => {
      const id = link.getAttribute('href');
      const target = document.querySelector(id);
      if (!target) return;
      event.preventDefault();
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      history.pushState(null, '', id);
    });
  });

  const lessonSections = [...document.querySelectorAll('.lesson-section[id]')];
  const lessonLinks = [...document.querySelectorAll('.lesson-toc a[href^="#"]')];
  if (lessonSections.length && lessonLinks.length && 'IntersectionObserver' in window) {
    const linkMap = new Map(lessonLinks.map((link) => [link.getAttribute('href').slice(1), link]));
    const observer = new IntersectionObserver((entries) => {
      entries.filter((entry) => entry.isIntersecting).forEach((entry) => {
        lessonLinks.forEach((link) => link.classList.remove('is-active'));
        const active = linkMap.get(entry.target.id);
        if (active) active.classList.add('is-active');
      });
    }, { rootMargin: '-18% 0px -68% 0px', threshold: 0.01 });
    lessonSections.forEach((section) => observer.observe(section));
  }

  document.querySelectorAll('.nav-links details').forEach((details) => {
    details.addEventListener('toggle', () => {
      if (!details.open) return;
      document.querySelectorAll('.nav-links details').forEach((other) => {
        if (other !== details) other.removeAttribute('open');
      });
    });
  });

  const search = document.querySelector('[data-search]');
  if (search) {
    const items = [...document.querySelectorAll('[data-search-item]')];
    search.addEventListener('input', () => {
      const q = search.value.trim().toLowerCase();
      items.forEach((item) => {
        item.classList.toggle('hide', Boolean(q) && !item.textContent.toLowerCase().includes(q));
      });
    });
  }

  document.querySelectorAll('[data-copy-target]').forEach((button) => {
    button.addEventListener('click', async () => {
      const targetId = button.getAttribute('data-copy-target');
      const target = targetId ? document.getElementById(targetId) : null;
      if (!target) return;
      const original = button.textContent;
      try {
        await navigator.clipboard.writeText(target.textContent || '');
        button.textContent = 'Copied';
      } catch (error) {
        button.textContent = 'Copy failed';
      }
      window.setTimeout(() => { button.textContent = original; }, 1400);
    });
  });

  document.querySelectorAll('[data-year]').forEach((el) => {
    el.textContent = new Date().getFullYear();
  });
})();

// Global image viewer for lesson images and reference screenshots
(() => {
  const clamp = (value, min, max) => Math.min(max, Math.max(min, value));

  const viewer = document.createElement('div');
  viewer.className = 'image-viewer';
  viewer.setAttribute('data-global-image-viewer', '');
  viewer.setAttribute('aria-hidden', 'true');
  viewer.innerHTML = `
    <div class="image-viewer-backdrop" data-viewer-close></div>
    <section class="image-viewer-dialog" role="dialog" aria-modal="true" aria-label="Expanded image viewer">
      <div class="image-viewer-toolbar">
        <span class="image-viewer-zoom-readout" data-viewer-zoom>100%</span>
        <button class="image-viewer-action" type="button" data-viewer-fit>Fit</button>
        <button class="image-viewer-action" type="button" data-viewer-one>100%</button>
        <button class="image-viewer-action" type="button" data-viewer-minus aria-label="Zoom out">−</button>
        <button class="image-viewer-action" type="button" data-viewer-plus aria-label="Zoom in">+</button>
        <button class="image-viewer-action" type="button" data-viewer-reset>Reset</button>
        <span class="image-viewer-toolbar-spacer"></span>
        <button class="image-viewer-close" type="button" data-viewer-close aria-label="Close image viewer">×</button>
      </div>
      <div class="image-viewer-stage" data-viewer-stage>
        <img class="image-viewer-image" data-viewer-image alt="" draggable="false" />
      </div>
      <div class="image-viewer-caption" data-viewer-caption></div>
    </section>
  `;
  document.body.appendChild(viewer);

  const stage = viewer.querySelector('[data-viewer-stage]');
  const image = viewer.querySelector('[data-viewer-image]');
  const caption = viewer.querySelector('[data-viewer-caption]');
  const zoomReadout = viewer.querySelector('[data-viewer-zoom]');
  const closeButtons = viewer.querySelectorAll('[data-viewer-close]');

  let lastFocused = null;
  let scale = 1;
  let tx = 0;
  let ty = 0;
  let baseScale = 1;
  let naturalWidth = 0;
  let naturalHeight = 0;
  let dragging = false;
  let dragStartX = 0;
  let dragStartY = 0;
  let originX = 0;
  let originY = 0;

  const update = () => {
    image.style.transform = `translate3d(${tx}px, ${ty}px, 0) scale(${scale})`;
    zoomReadout.textContent = `${Math.round((scale / baseScale) * 100)}%`;
  };

  const resetPosition = () => {
    tx = 0;
    ty = 0;
    update();
  };

  const fit = () => {
    if (!naturalWidth || !naturalHeight) return;
    const maxW = Math.max(200, stage.clientWidth - 24);
    const maxH = Math.max(200, stage.clientHeight - 24);
    baseScale = Math.min(maxW / naturalWidth, maxH / naturalHeight, 1);
    scale = baseScale;
    resetPosition();
  };

  const setRelativeZoom = (factor) => {
    scale = clamp(scale * factor, baseScale, baseScale * 5);
    update();
  };

  const setOneHundred = () => {
    scale = Math.max(baseScale, 1);
    resetPosition();
  };

  const close = () => {
    viewer.classList.remove('is-open');
    viewer.setAttribute('aria-hidden', 'true');
    document.body.style.overflow = '';
    image.removeAttribute('src');
    if (lastFocused) lastFocused.focus();
  };

  const open = (sourceImage, trigger) => {
    const src = trigger?.getAttribute('href') || sourceImage.currentSrc || sourceImage.src;
    if (!src) return;
    lastFocused = trigger || sourceImage;
    image.src = src;
    image.alt = sourceImage.alt || '';
    const figure = sourceImage.closest('figure');
    const figcaption = figure?.querySelector('figcaption')?.textContent?.trim();
    caption.textContent = figcaption || sourceImage.alt || '';
    viewer.classList.add('is-open');
    viewer.setAttribute('aria-hidden', 'false');
    document.body.style.overflow = 'hidden';
    image.onload = () => {
      naturalWidth = image.naturalWidth;
      naturalHeight = image.naturalHeight;
      window.requestAnimationFrame(fit);
    };
    if (image.complete) {
      naturalWidth = image.naturalWidth;
      naturalHeight = image.naturalHeight;
      window.requestAnimationFrame(fit);
    }
  };

  document.addEventListener('click', (event) => {
    const imageTarget = event.target instanceof Element ? event.target.closest('.lesson-content img') : null;
    if (!imageTarget) return;
    const link = imageTarget.closest('a');
    const href = link?.getAttribute('href') || '';
    if (href && !/\.(?:png|jpe?g|gif|webp|svg)(?:[?#].*)?$/i.test(href)) return;
    event.preventDefault();
    open(imageTarget, link);
  });

  document.querySelectorAll('.lesson-content img').forEach((img) => {
    if (!img.hasAttribute('tabindex')) img.setAttribute('tabindex', '0');
    img.setAttribute('role', 'button');
  });

  viewer.querySelector('[data-viewer-plus]').addEventListener('click', () => setRelativeZoom(1.2));
  viewer.querySelector('[data-viewer-minus]').addEventListener('click', () => setRelativeZoom(1 / 1.2));
  viewer.querySelector('[data-viewer-fit]').addEventListener('click', fit);
  viewer.querySelector('[data-viewer-one]').addEventListener('click', setOneHundred);
  viewer.querySelector('[data-viewer-reset]').addEventListener('click', fit);
  closeButtons.forEach((button) => button.addEventListener('click', close));

  stage.addEventListener('wheel', (event) => {
    if (!viewer.classList.contains('is-open')) return;
    event.preventDefault();
    setRelativeZoom(event.deltaY < 0 ? 1.12 : 1 / 1.12);
  }, { passive: false });

  stage.addEventListener('pointerdown', (event) => {
    if (scale <= baseScale) return;
    dragging = true;
    stage.classList.add('is-dragging');
    dragStartX = event.clientX;
    dragStartY = event.clientY;
    originX = tx;
    originY = ty;
    stage.setPointerCapture(event.pointerId);
  });

  stage.addEventListener('pointermove', (event) => {
    if (!dragging) return;
    tx = originX + (event.clientX - dragStartX);
    ty = originY + (event.clientY - dragStartY);
    update();
  });

  const endDrag = (event) => {
    if (!dragging) return;
    dragging = false;
    stage.classList.remove('is-dragging');
    if (stage.hasPointerCapture(event.pointerId)) stage.releasePointerCapture(event.pointerId);
  };
  stage.addEventListener('pointerup', endDrag);
  stage.addEventListener('pointercancel', endDrag);

  document.addEventListener('keydown', (event) => {
    if (!viewer.classList.contains('is-open')) return;
    if (event.key === 'Escape') close();
    if (event.key === '+' || event.key === '=') setRelativeZoom(1.2);
    if (event.key === '-' || event.key === '_') setRelativeZoom(1 / 1.2);
    if (event.key === '0') fit();
    if (event.key === '1') setOneHundred();
  });

  window.addEventListener('resize', () => {
    if (viewer.classList.contains('is-open')) fit();
  });
})();

