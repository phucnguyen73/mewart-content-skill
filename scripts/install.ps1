<#
  Bộ cài skill mewart-content-agent cho Windows.
  Chạy:  powershell -ExecutionPolicy Bypass -File scripts\install.ps1
  Tuỳ chọn:
    -SkipDeps    Không tự cài Node / lark-cli
    -VerifyOnly  Chỉ kiểm tra, không cài gì

  Script KHÔNG xử lý App Secret. Bước nhập secret và đăng nhập Lark nằm trong INSTALL.md (bước 4–5).
  Mỗi dòng kết quả có tiền tố [OK] / [CÀI] / [CẦN LÀM] / [LỖI] để AI đọc được.
#>
param([switch]$SkipDeps, [switch]$VerifyOnly)
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [Text.Encoding]::UTF8

$RepoRoot   = Split-Path -Parent $PSScriptRoot
$SkillName  = 'mewart-content-agent'
$SkillSrc   = Join-Path $RepoRoot "skills\$SkillName"
$SkillsDir  = Join-Path $HOME '.claude\skills'
$SkillDst   = Join-Path $SkillsDir $SkillName
$AppId      = 'cli_a985b5bc3ff85ed4'
$Profile    = 'mewart'
$BaseToken  = 'N0uub2iuPadQSlsxdyVl3aARguc'
$todo = @()

function Refresh-Path {
  $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')
}
function Has($cmd) { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }

# 1. Node.js >= 18
$nodeOk = $false
if (Has node) { $v = (node -v) -replace '^v',''; $nodeOk = ([version]$v -ge [version]'18.0.0') }
if ($nodeOk) { Write-Output "[OK] Node $(node -v)" }
elseif ($VerifyOnly -or $SkipDeps) { Write-Output "[CẦN LÀM] Cài Node.js >= 18"; $todo += 'node' }
else {
  if (-not (Has winget)) { Write-Output "[LỖI] Không có winget. Tải Node LTS tại https://nodejs.org rồi chạy lại."; exit 1 }
  Write-Output "[CÀI] Node.js LTS qua winget..."
  winget install --id OpenJS.NodeJS.LTS -e --accept-source-agreements --accept-package-agreements --silent | Out-Null
  Refresh-Path
  if (Has node) { Write-Output "[OK] Node $(node -v)" } else { Write-Output "[LỖI] Đã cài Node nhưng chưa thấy trong PATH. Mở terminal mới rồi chạy lại."; exit 1 }
}

# 2. lark-cli
if (Has lark-cli) { Write-Output "[OK] lark-cli $(lark-cli --version)" }
elseif ($VerifyOnly -or $SkipDeps) { Write-Output "[CẦN LÀM] Cài lark-cli: npm install -g @larksuite/cli"; $todo += 'lark-cli' }
else {
  Write-Output "[CÀI] lark-cli (npm install -g @larksuite/cli)..."
  npm install -g @larksuite/cli | Out-Null
  Refresh-Path
  if (Has lark-cli) { Write-Output "[OK] lark-cli $(lark-cli --version)" } else { Write-Output "[LỖI] Cài lark-cli thất bại. Thử mở terminal mới rồi chạy lại."; exit 1 }
}

# 3. Copy skill (sao lưu bản cũ nếu có)
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

# 4. Profile Lark 'mewart'
$hasProfile = $false
if (Has lark-cli) {
  $plist = lark-cli profile list 2>$null | Out-String
  $hasProfile = $plist -match "`"name`":\s*`"$Profile`""
}
if ($hasProfile) { Write-Output "[OK] Có profile Lark '$Profile'" }
else { Write-Output "[CẦN LÀM] Tạo profile Lark '$Profile' (INSTALL.md bước 4, cần App Secret của $AppId)"; $todo += 'profile' }

# 5. Đăng nhập và quyền vào base
if ($hasProfile) {
  $st = lark-cli --profile $Profile auth status 2>$null | Out-String
  if ($st -match '"userName":\s*"([^"]+)"') {
    Write-Output "[OK] Đã đăng nhập Lark: $($Matches[1])"
    $bg = lark-cli --profile $Profile base +base-get --base-token $BaseToken --as user 2>&1 | Out-String
    if ($bg -match '"ok":\s*true') { Write-Output "[OK] Truy cập được base 'Quản lý CONTENT MEW ART MAKEUP'" }
    else { Write-Output "[CẦN LÀM] Tài khoản chưa có quyền vào base content. Nhờ quản lý share base + wiki MEWART - MARKETING 2026."; $todo += 'permission' }
  } else { Write-Output "[CẦN LÀM] Đăng nhập Lark (INSTALL.md bước 5)"; $todo += 'login' }
}

if ($todo.Count -eq 0) { Write-Output "[XONG] Cài đặt hoàn tất. Khởi động lại OpenCode / Claude Code để nạp skill." }
else { Write-Output "[CÒN] $($todo -join ', ')" }
