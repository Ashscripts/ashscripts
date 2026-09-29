(() => {
  const pathParts = location.pathname.replace(/\/+$/, '').split('/').filter(Boolean);
  const requestedSlug = pathParts.length ? pathParts[pathParts.length - 1] : '';
  const titleEl = document.querySelector('#lessonTitle');
  const introEl = document.querySelector('#lessonIntro');
  const crumbEl = document.querySelector('#lessonBreadcrumb');
  const phaseTag = document.querySelector('#lessonPhaseTag');
  const side = document.querySelector('#lessonSide');
  const overview = document.querySelector('#lessonOverview');
  const related = document.querySelector('#relatedLessons');
  if (!requestedSlug || requestedSlug === 'intune' || !titleEl) return;

  const escapeHtml = (value) => String(value).replace(/[&<>\"]/g, (ch) => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[ch]));

  fetch(new URL('../../assets/data/intune-tutorial.json', document.baseURI).href)
    .then((response) => {
      if (!response.ok) throw new Error('Unable to load Intune curriculum');
      return response.json();
    })
    .then((phases) => {
      let match = null;
      let matchPhase = null;
      phases.some((phase) => phase.lessons.some((lesson) => {
        if (lesson.slug === requestedSlug) {
          match = lesson;
          matchPhase = phase;
          return true;
        }
        return false;
      }));

      if (!match || !matchPhase) throw new Error('Lesson not found');

      document.title = `${match.id} ${match.title} · Intune Tutorials · ashscript`;
      titleEl.textContent = `${match.id} ${match.title}`;
      introEl.textContent = matchPhase.intro;
      crumbEl.textContent = match.id;
      phaseTag.textContent = `Phase ${matchPhase.id} · ${matchPhase.title}`;
      phaseTag.style.setProperty('--phase-color', matchPhase.color);
      phaseTag.style.borderColor = `${matchPhase.color}55`;
      phaseTag.style.color = matchPhase.color;

      side.innerHTML = `
        <div class="toc-label">Current phase</div>
        <div class="lesson-phase-marker" style="--phase-color:${matchPhase.color}" aria-hidden="true"></div>
        <strong>Phase ${matchPhase.id}: ${escapeHtml(matchPhase.title)}</strong>
        <span>Story navigation</span>
        <a href="../#phase-${matchPhase.id}">Go to Learning Modules</a>`;

      overview.innerHTML = `
        <div class="lesson-overview-item"><span>Lesson</span><strong>${escapeHtml(match.id)}</strong></div>
        <div class="lesson-overview-item"><span>Phase</span><strong>${escapeHtml(matchPhase.title)}</strong></div>
        <div class="lesson-overview-item"><span>Sequence</span><strong>${matchPhase.lessons.findIndex((lesson) => lesson.id === match.id) + 1} of ${matchPhase.lessons.length}</strong></div>
        <div class="lesson-overview-item"><span>Curriculum</span><strong>Microsoft Intune</strong></div>`;

      related.innerHTML = matchPhase.lessons.map((lesson) => `
        <a class="related-lesson ${lesson.id === match.id ? 'is-current' : ''}" href="../${encodeURIComponent(lesson.slug)}/">
          <span>${escapeHtml(lesson.id)}</span>
          <strong>${escapeHtml(lesson.title)}</strong>
        </a>`).join('');

      const allLessons = phases.flatMap((phase) => phase.lessons.map((lesson) => ({ ...lesson, phaseId: phase.id })));
      const currentIndex = allLessons.findIndex((lesson) => lesson.id === match.id);
      const previous = currentIndex > 0 ? allLessons[currentIndex - 1] : null;
      const next = currentIndex < allLessons.length - 1 ? allLessons[currentIndex + 1] : null;
      const actions = document.querySelector('#lessonActions');
      if (actions) {
        const links = [];
        if (previous) links.push(`<a class="btn btn-ghost" href="../${encodeURIComponent(previous.slug)}/">← ${escapeHtml(previous.id)} ${escapeHtml(previous.title)}</a>`);
        links.push('<a class="btn btn-primary" href="../">Go to Learning Modules</a>');
        if (next) links.push(`<a class="btn btn-ghost" href="../${encodeURIComponent(next.slug)}/">${escapeHtml(next.id)} ${escapeHtml(next.title)} →</a>`);
        actions.innerHTML = links.join('');
      }
    })
    .catch(() => {
      titleEl.textContent = 'Lesson not found';
      introEl.textContent = 'Return to the Intune tutorial index and choose a lesson from the curriculum.';
      if (side) side.innerHTML = '<a href="../">← Intune Tutorials</a>';
    });
})();
