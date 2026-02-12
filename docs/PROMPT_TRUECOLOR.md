# Bash Prompt Truecolor Upgrade

## What Changed

Your `.bash_prompt` has been upgraded to support **24-bit truecolor** with the **Nord** color palette while maintaining backward compatibility.

### Implementation Details

1. **Truecolor Detection** (`supports_truecolor`)
   - Auto-detects via `COLORTERM` (checks for `truecolor`/`24bit`)
   - Recognizes iTerm.app and Apple Terminal
   - Guards against `TERM=dumb` and `NO_COLOR`

2. **Conditional COLORTERM Export**
   - Only exports `COLORTERM=truecolor` when truecolor is actually supported
   - Prevents misleading downstream tools over SSH/tmux

3. **Color Helpers**
   - `hex_to_rgb()`: Converts hex colors to RGB decimal values
   - `fg_hex()`: Generates 24-bit ANSI escape sequences (`\e[38;2;R;G;Bm`)

4. **Nord Palette** (Truecolor Mode)
   ```
   red=#BF616A    orange=#D08770  yellow=#EBCB8B  green=#A3BE8C
   cyan=#88C0D0   blue=#81A1C1    purple=#B48EAD  violet=#B48EAD
   black=#3B4252  white=#ECEFF4
   ```

5. **ANSI Fallback** (Non-Truecolor)
   - Simple 16-color ANSI escape sequences
   - No dependency on `tput` or 256-color mapping

6. **Git Prompt Logic**
   - **Completely unchanged** – all git commands and indicators preserved
   - Indicators: `+` (staged), `!` (unstaged), `?` (untracked), `$` (stashed)

## Verification

### 1. Check Detection
```bash
# Open a new terminal, then:
echo "COLORTERM=${COLORTERM}"  # Should be "truecolor"
echo "TERM=${TERM}"            # Should be "xterm-256color" or similar
```

### 2. Verify 24-bit Colors
```bash
printf "red=%q\n" "$red"  # Should show \E[38;2;R;G;Bm format
```

### 3. Test Git Indicators
```bash
cd ~/your-git-repo
# Prompt should show branch name + status indicators
# Make a change, see "!" appear
# Stage it, see "+" appear
```

### 4. Test Fallback
```bash
# Simulate a dumb terminal:
TERM=dumb bash --noprofile --norc
source ~/.bash_prompt
# Should fall back to basic ANSI without errors
```

## Switching Themes

To use a different palette (Solarized Dark or Gruvbox Dark), edit `.bash_prompt` lines 101-122 and replace the Nord hex values:

### Solarized Dark
```bash
red=$(fg_hex "#dc322f");
orange=$(fg_hex "#cb4b16");
yellow=$(fg_hex "#b58900");
green=$(fg_hex "#859900");
cyan=$(fg_hex "#2aa198");
blue=$(fg_hex "#268bd2");
purple=$(fg_hex "#d33682");
violet=$(fg_hex "#6c71c4");
black=$(fg_hex "#002b36");
white=$(fg_hex "#fdf6e3");
```

### Gruvbox Dark
```bash
red=$(fg_hex "#fb4934");
orange=$(fg_hex "#fe8019");
yellow=$(fg_hex "#fabd2f");
green=$(fg_hex "#b8bb26");
cyan=$(fg_hex "#8ec07c");
blue=$(fg_hex "#83a598");
purple=$(fg_hex "#d3869b");
violet=$(fg_hex "#d3869b");
black=$(fg_hex "#282828");
white=$(fg_hex "#ebdbb2");
```

## Compatibility Notes

- **macOS**: Works with Terminal.app, iTerm2
- **Bash Version**: Compatible with Bash 3.2+ (macOS default)
- **SSH/tmux**: Auto-detection prevents forcing truecolor when not supported
- **Color Variables**: Raw escape sequences work in both PS1 and `.exports` (e.g., `LESS_TERMCAP_md`)

## Reload Prompt

After any changes:
```bash
source ~/.bash_prompt
# Or open a new terminal
```
