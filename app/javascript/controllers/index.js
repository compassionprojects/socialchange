// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application";
import ModalController from "./modal_controller";
import ContributorsController from "./contributors_controller";

application.register("modal", ModalController);
application.register("contributors", ContributorsController);
