vimScopes Constant
==================

Vim calls regions that can be colored `scopes`. These are not to be confused
with Angular's concept of scopes.

    'use strict'
    angular.module('Villustrator')
    .constant 'vimScopes', Object.freeze [
      { desc: 'Background', vimScope: 'Normal', bg: true }
      { desc: 'Normal', vimScope: 'Normal' }
      { desc: 'Comments', vimScope: 'Comment' }
      { desc: 'Constants', vimScope: 'Constant' }
      { desc: 'Strings', vimScope: 'String' }
      { desc: 'HTML Tag Names', vimScope: 'htmlTagName' }
      { desc: 'Identifiers', vimScope: 'Identifier' }
      { desc: 'Statements', vimScope: 'Statement' }
      { desc: 'Pre-processors', vimScope: 'PreProc' }
      { desc: 'Type Declarations', vimScope: 'Type' }
      { desc: 'Functions', vimScope: 'Function' }
      { desc: 'Repeated Expressions', vimScope: 'Repeat' }
      { desc: 'Operators', vimScope: 'Operator' }
    ]
