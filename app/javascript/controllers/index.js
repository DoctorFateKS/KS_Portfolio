import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Cette ligne scanne automatiquement vos contrôleurs grâce à l'importmap
eagerLoadControllersFrom("controllers", application)
