// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application";
import ModalController from "./modal_controller";
import TooltipController from "./tooltip_controller";

application.register("modal", ModalController);
application.register("tooltip", TooltipController);
