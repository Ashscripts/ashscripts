(() => {
  const phaseNav = document.querySelector('#phaseNav');
  const phaseList = document.querySelector('#phaseList');
  const stats = document.querySelector('#intuneStats');
  if (!phaseNav || !phaseList) return;

  const escapeHtml = (value) => String(value).replace(/[&<>\"]/g, (ch) => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[ch]));

  fetch(new URL('../assets/data/intune-tutorial.json', document.baseURI).href)
    .then((response) => {
      if (!response.ok) throw new Error('Unable to load Intune curriculum');
      return response.json();
    })
    .then((phases) => {
      const lessonCount = phases.reduce((sum, phase) => sum + phase.lessons.length, 0);
      if (stats) {
        stats.innerHTML = `
          <div class="intune-stat"><strong>${phases.length}</strong><span>phases</span></div>
          <div class="intune-stat"><strong>${lessonCount}</strong><span>lessons</span></div>
          <div class="intune-stat"><strong>1 → 9</strong><span>guided progression</span></div>`;
      }

      phaseNav.innerHTML = phases.map((phase) => `
        <a aria-label="Phase ${phase.id} ${escapeHtml(phase.title)}" class="phase-nav-link" href="#phase-${phase.id}" data-phase-target="phase-${phase.id}">
          <span class="phase-nav-dot" style="--phase-color:${phase.color}" aria-hidden="true"></span>
          <span><strong>Phase ${phase.id} · ${escapeHtml(phase.title)}</strong></span>
        </a>`).join('');

      phaseList.innerHTML = phases.map((phase) => `
        <section class="phase-panel" id="phase-${phase.id}" style="--phase-color:${phase.color}">
          <div class="phase-heading">
            <div class="phase-heading-marker" aria-hidden="true"></div>
            <div>
              <div class="phase-kicker">Phase ${phase.id}</div>
              <h2>${escapeHtml(phase.title)}</h2>
              <p>${escapeHtml(phase.intro)}</p>
            </div>
          </div>
          <div class="phase-lessons" role="list">
            ${phase.lessons.map((lesson) => `
              <a class="lesson-row" role="listitem" href="${encodeURIComponent(lesson.slug)}/">
                <span class="lesson-id">${escapeHtml(lesson.id)}</span>
                <span class="lesson-title">${escapeHtml(lesson.title)}</span>
                <span class="lesson-link">${lesson.status === 'live' ? 'Read chapter →' : 'Coming soon'}</span>
              </a>`).join('')}
          </div>
        </section>`).join('');

      phaseNav.addEventListener('click', (event) => {
        const link = event.target.closest('a[data-phase-target]');
        if (!link) return;
        const id = link.getAttribute('data-phase-target');
        const target = document.getElementById(id);
        if (!target) return;
        event.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
        history.pushState(null, '', `#${id}`);
        document.querySelectorAll('.phase-focus').forEach((el) => el.classList.remove('phase-focus'));
        target.classList.add('phase-focus');
      });

      const onHashChange = () => {
        document.querySelectorAll('.phase-focus').forEach((el) => el.classList.remove('phase-focus'));
        const hash = window.location.hash;
        if (!hash) return;
        const target = document.querySelector(hash);
        if (target) target.classList.add('phase-focus');
      };
      onHashChange();
      requestAnimationFrame(() => onHashChange());
      window.addEventListener('hashchange', onHashChange);
      const phaseLinks = [...phaseNav.querySelectorAll('a[data-phase-target]')];
      const phasePanels = [...phaseList.querySelectorAll('.phase-panel[id]')];
      if ('IntersectionObserver' in window) {
        const phaseNavObserver = new IntersectionObserver((entries) => {
          entries.filter((entry) => entry.isIntersecting).forEach((entry) => {
            phaseLinks.forEach((a) => a.classList.remove('is-active'));
            const active = phaseLinks.find((a) => a.getAttribute('data-phase-target') === entry.target.id);
            if (active) active.classList.add('is-active');
          });
        }, { rootMargin: '-24% 0px -64% 0px', threshold: 0.01 });
        phasePanels.forEach((panel) => phaseNavObserver.observe(panel));
      }
    })
    .catch(() => {
      phaseList.innerHTML = '<div class="callout"><strong>Curriculum could not be loaded.</strong><span>Check that assets/data/intune-tutorial.json is published with the site.</span></div>';
    });
})();
