(() => {
  const toggle = document.querySelector('[data-menu-toggle]');
  const nav = document.querySelector('[data-nav]');
  if (toggle && nav) {
    toggle.addEventListener('click', () => nav.classList.toggle('open'));
  }

  // Close details menus when another one opens.
  document.querySelectorAll('.nav-links details').forEach(d => {
    d.addEventListener('toggle', () => {
      if (d.open) {
        document.querySelectorAll('.nav-links details').forEach(other => {
          if (other !== d) other.removeAttribute('open');
        });
      }
    });
  });

  // Blog/search filtering.
  const search = document.querySelector('[data-search]');
  if (search) {
    const items = [...document.querySelectorAll('[data-search-item]')];
    search.addEventListener('input', () => {
      const q = search.value.trim().toLowerCase();
      items.forEach(item => {
        const text = item.textContent.toLowerCase();
        item.classList.toggle('hide', q && !text.includes(q));
      });
    });
  }

  // Current year.
  document.querySelectorAll('[data-year]').forEach(el => el.textContent = new Date().getFullYear());
})();
