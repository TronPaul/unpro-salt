function ps1_context {
    # For any of these bits of context that exist, display them and append
    # a space.
    virtualenv=`basename "$VIRTUAL_ENV"`
    for v in "$debian_chroot" "$virtualenv" "$PS1_CONTEXT"; do
        echo -n "${v:+$v }"
    done
}

export PS1="$(ps1_context)"'\u@\h:\w\$ '

