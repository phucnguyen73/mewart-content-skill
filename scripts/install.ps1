<#
  Bộ cài skill mewart-content-agent cho Windows.
  Chạy:  powershell -ExecutionPolicy Bypass -File scripts\install.ps1 [-VerifyOnly]

  Giả định máy ĐÃ có lark-cli được cấu hình sẵn cho Lark Mewart.
  Script không đổi cấu hình lark-cli.
  Mỗi dòng kết quả có tiền tố [OK] / [CẦN LÀM] / [LỖI] / [XONG] / [CÒN] để AI đọc được.
#>
param([switch]$VerifyOnly)
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [Text.Encoding]::UTF8

$RepoRoot  = Split-Path -Parent $PSScriptRoot
$SkillName = 'mewart-content-agent'
$SkillSrc  = Join-Path $RepoRoot "skills\$SkillName"
$SkillsDir = Join-Path $HOME '.claude\skills'
$SkillDst  = Join-Path $SkillsDir $SkillName
$BaseToken = 'N0uub2iuPadQSlsxdyVl3aARguc'
$todo = @()
function Has($cmd) { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }

# 1. Copy skill (sao lưu bản cũ nếu có)
if ($VerifyOnly) {
  if (Test-Path "$SkillDst\SKILL.md") { Write-Output "[OK] Skill có tại $SkillDst" } else { Write-Output "[CẦN LÀM] Chưa cài skill"; $todo += 'skill' }
} else {
  New-Item -ItemType Directory -Force $SkillsDir | Out-Null
  if (Test-Path $SkillDst) {
    $bk = Join-Path $SkillsDir ".backup\$SkillName-$(Get-Date -Format yyyyMMdd-HHmmss)"
    New-Item -ItemType Directory -Force (Split-Path $bk) | Out-Null
    Move-Item $SkillDst $bk
    Write-Output "[OK] Đã sao lưu bản cũ vào $bk"
  }
  Copy-Item $SkillSrc $SkillsDir -Recurse
  Write-Output "[OK] Đã cài skill vào $SkillDst"
}

# 2. lark-cli có sẵn?
if (-not (Has lark-cli)) {
  Write-Output "[LỖI] Máy chưa có lark-cli. Bộ cài này giả định lark-cli đã được cấu hình sẵn cho Lark Mewart; nhờ anh Nguyên cài trước."
  exit 1
}
Write-Output "[OK] lark-cli $(lark-cli --version)"

# 3. Profile nào vào được base content (ưu tiên profile mặc định)
function Test-Base($prof) {
  $args2 = @('base','+base-get','--base-token',$BaseToken,'--as','user')
  if ($prof) { $args2 = @('--profile',$prof) + $args2 }
  $out = & lark-cli @args2 2>&1 | Out-String
  return ($out -match '"ok":\s*true')
}
$found = $null
if (Test-Base $null) { $found = '(mặc định)' }
else {
  $names = @()
  try { $names = (lark-cli profile list 2>$null | Out-String | ConvertFrom-Json) | ForEach-Object { $_.name } } catch {}
  foreach ($n in $names) { if (Test-Base $n) { $found = $n; break } }
}

if ($found -eq '(mặc định)') {
  $st = lark-cli auth status 2>$null | Out-String
  $u = if ($st -match '"userName":\s*"([^"]+)"') { $Matches[1] } else { '?' }
  Write-Output "[OK] Profile mặc định vào được base content (user: $u)"
} elseif ($found) {
  Write-Output "[OK] Profile '$found' vào được base content. Skill sẽ tự thêm --profile $found (không đổi profile mặc định)."
} else {
  $st = lark-cli auth status 2>$null | Out-String
  if ($st -match '"status":\s*"(expired|not_logged_in|unavailable)"' -or $st -notmatch '"userName"') {
    Write-Output "[CẦN LÀM] Đăng nhập Lark (INSTALL.md bước 3)"; $todo += 'login'
  } else {
    Write-Output "[CẦN LÀM] Đã đăng nhập nhưng chưa vào được base content. Nhờ quản lý share base 'Quản lý CONTENT MEW ART MAKEUP' + wiki 'MEWART - MARKETING 2026' (quyền chỉnh sửa), hoặc đăng nhập lại (INSTALL.md bước 3)."
    $todo += 'permission'
  }
}

if ($todo.Count -eq 0) { Write-Output "[XONG] Cài đặt hoàn tất. Khởi động lại OpenCode / Claude Code để nạp skill." }
else { Write-Output "[CÒN] $($todo -join ', ')" }
