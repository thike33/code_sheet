// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"
import CodeCopyController from "./code_copy_controller"
import ChangeFormController from "./change_form_controller"
import indexSortController from "./index_sort_controller"
import { Autocomplete } from 'stimulus-autocomplete'

application.register("code-copy", CodeCopyController)
application.register("change-form", ChangeFormController)
application.register("index-sort", indexSortController)
application.register('autocomplete', Autocomplete)