{ inputs, machine, config, pkgs,  ... } : {
    home.packages = [
        (pkgs.writeShellApplication {
            name = "nixup";

            runtimeInputs = with pkgs; [
                git
                nixos-rebuild
            ];

            text = ''
                set -euo pipefail

                REPO="$HOME/.config/nixos"

                cd "$REPO"

                echo "==> Checking git repository..."

                if [[ -z "$(git status --porcelain)" ]]; then
                    echo "No changes to commit."
                else
                    git add -A

                    DATE="$(date '+%Y-%m-%d')"

                    # Determine whether HEAD is already pushed.
                    if git rev-parse --verify '@{upstream}' >/dev/null 2>&1; then
                        UPSTREAM="$(git rev-parse '@{upstream}')"
                        HEAD="$(git rev-parse HEAD)"

                        if [[ "$HEAD" == "$UPSTREAM" ]]; then
                            echo "==> Creating new commit..."
                            git commit -m "$DATE"

                        elif git merge-base --is-ancestor "$UPSTREAM" "$HEAD"; then
                            echo "==> Amending local commit..."
                            git commit --amend -m "$DATE"

                        else
                            echo "ERROR: Local branch has diverged from upstream."
                            echo "Resolve the git situation manually before using nixup."
                            exit 1
                        fi
                    else
                        echo "==> No upstream configured; creating new commit..."
                        git commit -m "$DATE"
                    fi
                fi

                echo
                echo "==> Rebuilding NixOS..."

                sudo nixos-rebuild switch --flake "$REPO"
            '';
        })
    ];
}