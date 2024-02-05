import { application } from "./application";
import ModalController from "./modal_controller";
import ContributorsController from "./contributors_controller";
import StoryFormController from "./story_form_controller";

application.register("modal", ModalController);
application.register("story-form", StoryFormController);
