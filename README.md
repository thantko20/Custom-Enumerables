# Custom Enumerables
 This is a project where I have to recreate some buil-in methods from Enumerable module.
 This project heavily uses Blocks concept of Ruby.

## Methods Recreated
- #my_each
- #my_each_with_index
- #my_select
- #my_all?
- #my_any?
- #my_none?
- #my_count
- #my_map
- #my_inject

## Few weak spots
Some methods only work for arrays and if the arrays contain nil value, it won't work.(I could've implemented this but I'm kinda lazy.)
#my_inject doesn't accept symbol parameter.
