#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# HTML Report Engine
# ==========================================================

html_report() {

print_title "HTML REPORT"

HTML_FILE="$REPORT_DIR/report_$(date +%F_%H-%M-%S).html"

cat > "$HTML_FILE" <<HTML
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>MUTEB SOC Report</title>
<style>
body{
background:#0d1117;
color:#58a6ff;
font-family:Consolas,monospace;
padding:40px;
}
table{
border-collapse:collapse;
width:70%;
}
td,th{
border:1px solid #30363d;
padding:8px;
}
th{
background:#161b22;
}
h1{
color:#39d353;
}
</style>
</head>
<body>

<h1>MUTEB SOC</h1>

<table>

<tr><th>Item</th><th>Value</th></tr>

<tr><td>Hostname</td><td>$(hostname)</td></tr>
<tr><td>User</td><td>$(whoami)</td></tr>
<tr><td>Kernel</td><td>$(uname -r)</td></tr>
<tr><td>Architecture</td><td>$(uname -m)</td></tr>
<tr><td>CPU</td><td>$(nproc)</td></tr>
<tr><td>Memory</td><td>$(free -h | awk '/Mem:/ {print $3 " / " $2}')</td></tr>
<tr><td>Disk</td><td>$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')</td></tr>
<tr><td>Generated</td><td>$(date)</td></tr>

</table>

</body>
</html>
HTML

print_success "HTML Report Saved"
echo "$HTML_FILE"

}

