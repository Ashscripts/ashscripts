(() => {
  const links = [...document.querySelectorAll('.lesson-toc a')];
  if (!links.length) return;
  const byId = links.map(a => document.getElementById(a.getAttribute('href').slice(1))).filter(Boolean);
  const activate = () => {
    const pos = window.scrollY + 140;
    let active = byId[0];
    for (const el of byId) if (el.offsetTop <= pos) active = el;
    links.forEach(a => a.classList.toggle('is-active', a.getAttribute('href') === '#' + active.id));
  };
  links.forEach(a => a.addEventListener('click', () => { setTimeout(activate, 60); }));
  window.addEventListener('scroll', activate, {passive:true});
  activate();
})();
