import { Application, Controller } from "@hotwired/stimulus"

class CategoryTreeController extends Controller {
  connect() {
    console.log("Hello, Stimulus!");
  }
}

const application = Application.start();

application.register("category-tree", CategoryTreeController);
