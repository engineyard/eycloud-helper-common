# ChangeLog

## v0.2

* `managed_template` - allows a recipe's files to have `keep.xyz` ("keep files") support
* `node[:owner_name]` & `node[:owner_pass]` attributes
* `chef` + `yajl-ruby` dependencies for use by "ey-recipes init --chef --on-deploy"

### v0.2.1

* Force a modern 0.10 chef or higher

## v0.1

* `ruby_block` is provided for recipes wanting to run on Chef 0.6 as well as modern Chef.