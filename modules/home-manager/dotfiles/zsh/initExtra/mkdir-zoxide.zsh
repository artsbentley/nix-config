m (){
    mkdir -p -- "$1" &&
    zoxide add "$1"
}
