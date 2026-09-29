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
