document.write('<script async src="https://www.googletagmanager.com/gtag/js?id={{ site.google_analytics }}"></script>')
document.write('<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client={{ site.google_adsense }}" crossorigin="anonymous"></script>')

window['ga-disable-{{ site.google_analytics }}'] = window.doNotTrack === "1" || navigator.doNotTrack === "1" || navigator.doNotTrack === "yes" || navigator.msDoNotTrack === "1";
window.dataLayer = window.dataLayer || [];
function gtag(){window.dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', '{{ site.google_analytics }}');
