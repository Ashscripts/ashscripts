(() => {
  const pathParts = location.pathname.replace(/\/+$/, '').split('/').filter(Boolean);
  const slug = pathParts.length ? pathParts[pathParts.length - 1] : '';
  const els={title:document.getElementById('pageTitle'),desc:document.getElementById('pageDescription'),crumb:document.getElementById('crumbTitle'),tag:document.getElementById('crumbTag'),meta:document.getElementById('meta'),lang:document.getElementById('language'),code:document.getElementById('code'),copy:document.getElementById('copyBtn'),download:document.getElementById('downloadBtn'),source:document.getElementById('sourceLink')};
  if(!slug || slug === 'scripts'){els.title.textContent='Script not found';els.desc.textContent='Choose a script from the Useful Scripts library.';return;}
  const esc=s=>String(s??'').replace(/[&<>\'\"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','\'':'&#39;','"':'&quot;'}[c]));
  const dataUrl = new URL('../../assets/data/scripts.json', document.baseURI).href;
  fetch(dataUrl, { cache: 'no-store' }).then(r=>{
    if(!r.ok) throw new Error(`HTTP ${r.status} while loading ${dataUrl}`);
    return r.json();
  }).then(items=>{
    if(!Array.isArray(items)) throw new Error('scripts.json did not contain an array');
    const x=items.find(i=>i.slug===slug); if(!x) throw new Error('Not found');
    document.title=`${x.title} · Useful Scripts · ashscript`;
    els.title.textContent=x.title; els.desc.textContent=x.description||''; els.crumb.textContent=x.title; els.tag.textContent=x.category||x.language; els.lang.textContent=x.language||'Script'; els.code.textContent=x.body||'';
    els.meta.innerHTML=`<span class="script-badge">${esc(x.category)}</span><span class="script-badge">${esc(x.language)}</span>${(x.tags||[]).map(t=>`<span class="script-tag">${esc(t)}</span>`).join('')}`;
    const src=x.source||''; const srcUrl = src ? new URL(`../../${src}`, document.baseURI).href : ''; els.source.href=srcUrl; els.download.href=srcUrl;
    els.copy.addEventListener('click',async()=>{try{await navigator.clipboard.writeText(x.body||'');const t=els.copy.textContent;els.copy.textContent='Copied ✓';setTimeout(()=>els.copy.textContent=t,1300)}catch{els.copy.textContent='Copy failed';setTimeout(()=>els.copy.textContent='Copy Script',1300)}});
  }).catch(err=>{console.error('Useful Script detail failed to load:',err);els.title.textContent='Script not found';els.desc.textContent='The requested script could not be located in the library.';});
})();
