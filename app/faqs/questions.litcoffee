questions
=========
This exposes an Angular constant that contains a list of Q&A objects.

    angular.module 'Villustrator.faqs'
    .constant 'questions', [

      q: 'Where do I put the colorscheme I just downloaded?'
      a: 'The colorscheme should be put in <pre>~/.vim/colors</pre>. If those
          directories don\'t already exist, you will need to create them.'

    ,

      q: 'The colors aren\'t showing up correctly. What\'s wrong?'
      a: 'Add this to your <pre>.vimrc</pre> file: <pre>set t_Co=256</pre>.'

    ,

      q: 'How do I change my colorscheme?'
      a: 'Just type <pre>:colorscheme colorSchemeName</pre> in Vim. To set your
          default colorscheme, just add that same statement to your
          <pre>.vimrc</pre> file in your home directory without the leading
          <pre>:</pre>.'

    ]
