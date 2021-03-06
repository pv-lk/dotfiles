function ot
    set -l TODAY (date +"%Y-%m-%d")
    set -l TODAYF ~/Org/Diario/$TODAY.org

    if not test -e $TODAYF && not pgrep -f org-roam-dailies-find-today && not pgrep -f org-roam-dailies-capture-today
        echo -e "#+title: $TODAY\n\n* Fugaz\n* Diario\n* Tareas" > $TODAYF
    end

    emacsclient -a '' -c $TODAYF
end
