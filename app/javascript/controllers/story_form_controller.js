import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";

// Story Form controller
export default class Tooltip extends Controller {
  static targets = [ "other", "category" ]

  isNewCategory() {
    const other = this.otherTarget;
    const category = this.categoryTarget;

    // if other is selected, show the input field to enter a new category name
    // otherwise hide the input field
    if (parseInt(category.value) === -1) {
      category.removeAttribute('required');
      other.classList.remove("d-none");
      other.setAttribute('required', 'true');
    } else {
      other.classList.add("d-none");
      other.removeAttribute('required');
    }
  }
}
