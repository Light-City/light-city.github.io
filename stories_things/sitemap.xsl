<?xml version="1.0" encoding="UTF-8"?>
<!--
  Browser-friendly view for sitemap.xml.

  Crawlers (Google/Bing) ignore the xml-stylesheet PI and read the raw XML,
  so hreflang xhtml:link data is unaffected. Humans get this table instead
  of Chrome's plain-text fallback (triggered by XHTML-namespace elements).
-->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:sm="http://www.sitemaps.org/schemas/sitemap/0.9"
                xmlns:xh="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="sm xh">
<xsl:output method="html" encoding="UTF-8" indent="yes"
            doctype-system="about:legacy-compat"/>

<xsl:template match="/">
<html lang="zh-CN">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="robots" content="noindex"/>
<title>站点地图 · C++那些事</title>
<style>
:root {
  color-scheme: light dark;
  --bg: #f6f7f9; --card: #ffffff; --text: #1f2430; --muted: #6b7280;
  --accent: #4051b5; --chip: #eef0fa; --chip-text: #4051b5;
  --border: #e5e7eb; --hover: #f3f4f6; --code: #374151;
}
@media (prefers-color-scheme: dark) {
  :root {
    --bg: #16181d; --card: #1e2128; --text: #e6e8ec; --muted: #9ca3af;
    --accent: #8c9eff; --chip: #2a2f3d; --chip-text: #aab6ff;
    --border: #2d313a; --hover: #262a33; --code: #c7cdd6;
  }
}
* { box-sizing: border-box; }
body {
  margin: 0; background: var(--bg); color: var(--text);
  font: 15px/1.6 -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
        "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", sans-serif;
}
.wrap { max-width: 1080px; margin: 0 auto; padding: 32px 20px 48px; }
header h1 { font-size: 22px; margin: 0 0 6px; }
header h1 .dot { color: var(--accent); }
header p { margin: 0; color: var(--muted); font-size: 13px; }
.stats {
  display: flex; flex-wrap: wrap; gap: 10px; align-items: center;
  margin: 18px 0 14px;
}
.stats .num {
  background: var(--card); border: 1px solid var(--border);
  border-radius: 10px; padding: 8px 14px; font-size: 13px; color: var(--muted);
}
.stats .num b { color: var(--text); font-size: 16px; margin-right: 4px; }
#q {
  flex: 1; min-width: 220px; padding: 9px 14px; font-size: 14px;
  border: 1px solid var(--border); border-radius: 10px; outline: none;
  background: var(--card); color: var(--text);
}
#q:focus { border-color: var(--accent); }
table {
  width: 100%; border-collapse: collapse; background: var(--card);
  border: 1px solid var(--border); border-radius: 12px; overflow: hidden;
  font-size: 14px;
}
th, td { padding: 9px 14px; text-align: left; vertical-align: top; }
thead th {
  font-size: 12px; letter-spacing: .04em; color: var(--muted);
  border-bottom: 1px solid var(--border); background: var(--hover);
  user-select: none;
}
tbody tr { border-bottom: 1px solid var(--border); }
tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: var(--hover); }
td.u a { color: var(--accent); text-decoration: none; word-break: break-all; }
td.u a:hover { text-decoration: underline; }
td.d { color: var(--muted); white-space: nowrap; font-variant-numeric: tabular-nums; }
.chips { display: flex; flex-wrap: wrap; gap: 4px; }
.chips a {
  font-size: 11px; padding: 1px 8px; border-radius: 99px;
  background: var(--chip); color: var(--chip-text); text-decoration: none;
}
.chips a:hover { filter: brightness(.92); }
footer { margin-top: 16px; color: var(--muted); font-size: 12px; }
code { font-family: ui-monospace, SFMono-Regular, Menlo, monospace; color: var(--code); }
</style>
</head>
<body>
<div class="wrap">
<header>
  <h1>站点地图<span class="dot"> · </span>C++那些事</h1>
  <p>光城 | Light City — 本页是 sitemap.xml 的浏览器友好视图，搜索引擎请直接读取
     <code>sitemap.xml</code> 原始 XML（含 hreflang 备用链接）。</p>
</header>

<div class="stats">
  <div class="num"><b><xsl:value-of select="count(sm:urlset/sm:url)"/></b>个地址</div>
  <div class="num"><b><xsl:value-of select="count(sm:urlset/sm:url/xh:link)"/></b>条语言版本链接</div>
  <input id="q" type="search" placeholder="过滤地址…" oninput="flt()"/>
</div>

<table id="sm">
<thead><tr>
  <th style="width:46%">地址</th>
  <th style="width:14%">最后更新</th>
  <th>语言版本</th>
</tr></thead>
<tbody>
<xsl:for-each select="sm:urlset/sm:url">
<tr>
  <td class="u">
    <a href="{sm:loc}">
      <xsl:value-of select="sm:loc"/>
    </a>
  </td>
  <td class="d"><xsl:value-of select="sm:lastmod"/></td>
  <td>
    <div class="chips">
      <xsl:for-each select="xh:link">
        <a href="{@href}" lang="{@hreflang}">
          <xsl:choose>
            <xsl:when test="@hreflang='x-default'">默认</xsl:when>
            <xsl:otherwise><xsl:value-of select="@hreflang"/></xsl:otherwise>
          </xsl:choose>
        </a>
      </xsl:for-each>
    </div>
  </td>
</tr>
</xsl:for-each>
</tbody>
</table>

<footer>
  共 <xsl:value-of select="count(sm:urlset/sm:url)"/> 个地址。
  未翻译的回退页面已从地图中移除（noindex），语言代码：
  zh 中文 · en English · ja 日本語 · es Español · ru Русский · pt Português · hi हिन्दी。
</footer>
</div>
<script>
function flt() {
  var q = document.getElementById('q').value.toLowerCase();
  var rows = document.querySelectorAll('#sm tbody tr');
  Array.prototype.forEach.call(rows, function (r) {
    var t = r.textContent.toLowerCase();
    r.style.display = (q === '' || t.indexOf(q) !== -1) ? '' : 'none';
  });
}
</script>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
