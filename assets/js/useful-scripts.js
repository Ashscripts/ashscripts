(() => {
  const search = document.getElementById('scriptSearch');
  const grid = document.getElementById('scriptGrid');
  const count = document.getElementById('scriptCount');
  const filterRow = document.getElementById('scriptFilters');
  if (!search || !grid) return;

  let scripts = [];
  let active = 'All';

  const esc = (s = '') => String(s).replace(/[&<>\'\"]/g, c => ({
    '&':'&amp;','<':'&lt;','>':'&gt;','\'':'&#39;','"':'&quot;'
  }[c]));

  const card = x => `<a class="card script-card" href="useful-script.html?script=${encodeURIComponent(x.slug)}">
    <div class="script-top"><span class="script-badge">${esc(x.category)}</span><div class="icon">${esc(x.n ?? '•')}</div></div>
    <div><h3>${esc(x.title)}</h3><p>${esc(x.description || x.title)}</p><div class="script-tags"><span class="script-tag">${esc(x.language)}</span>${(x.tags||[]).slice(0,4).map(t=>`<span class="script-tag">${esc(t)}</span>`).join('')}</div></div>
    <div class="link-row script-copy">View script <span>↗</span></div>
  </a>`;

  function render(){
    const q=(search.value||'').trim().toLowerCase();
    const out=scripts.filter(x => {
      const hay=[x.title,x.description,x.language,x.category,...(x.tags||[]),x.body||''].join(' ').toLowerCase();
      const filterOk=active==='All' || x.language===active || x.category===active;
      return filterOk && (!q || hay.includes(q));
    });
    grid.innerHTML=out.map(card).join('');
    if (count) count.textContent=`${out.length} script${out.length===1?'':'s'} found`;
  }

  function showLoadError(err){
    console.error('Useful Scripts library failed to load:', err);
    grid.innerHTML='<div class="callout"><strong>Library data could not be loaded.</strong><span> Refresh the page with Ctrl+F5. If it still fails, verify the site is being opened at <code>http://localhost:8000/</code> and that <code>assets/data/scripts.json</code> is present.</span></div>';
    if (count) count.textContent='';
  }

  const dataUrl = new URL('./assets/data/scripts.json', document.baseURI).href;
  fetch(dataUrl, { cache: 'no-store' })
    .then(r => {
      if (!r.ok) throw new Error(`HTTP ${r.status} while loading ${dataUrl}`);
      return r.json();
    })
    .then(d => {
      if (!Array.isArray(d)) throw new Error('scripts.json did not contain an array');
      scripts = d;
      render();
    })
    .catch(showLoadError);

  search.addEventListener('input',render);
  filterRow?.addEventListener('click',e=>{
    const b=e.target.closest('[data-filter]');
    if(!b) return;
    active=b.dataset.filter;
    filterRow.querySelectorAll('[data-filter]').forEach(x=>x.classList.toggle('active',x===b));
    render();
  });
})();
