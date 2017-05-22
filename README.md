# sicp-champions

## resources

* [SICP HTML Edition](http://sarabander.github.io/sicp/)
* [SICP Community Wiki - Solutions](http://community.schemewiki.org/?SICP-Solutions)
* [SICP Quizlet](https://quizlet.com/207946118/edit#addRow) - Password is sicp 
* [SICP Lectures](https://www.youtube.com/watch?v=2Op3QLzMgSY&list=PLE18841CABEA24090&index=1)

## scheme

We've chosen to use Racket.

## using vim for sicp

* [Configuring Vim for SICP](http://crash.net.nz/posts/2014/08/configuring-vim-for-sicp/)
* [Editing Lisp and Scheme files in vi] (http://ds26gte.github.io/scmindent/index.html)
* [tslime documentation](https://github.com/sjl/tslime.vim/blob/master/doc/tslime.txt)

Steps to set up SICP in VIM:

1. Open a terminal
2. enter a new tmux session with > tmux
3. split panes horizontally (ctrl+b ") or vertically (ctrl+b %)
4. open vim in one pane
5. switch to other pane with ctrl+b o 
6. open racket repl in the other pane 
7. in the vim pane, switch to visual mode with Ctrl+v. Switch to visual line mode with shift+v.
8. highlight code you want to send to repl 
9. press ctrl+c ctrl+c to activate tslime
10. if it is tslimes first time being activated in the current tmux session, it will ask for the window and pane to send the code to.
11. Additional QoL improvements can be made. These can be found in the first link in this section. 
