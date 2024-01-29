import { Controller } from "@hotwired/stimulus";
import * as bootstrap from "bootstrap";

// initialise bootstrap tooltips
export default class Tooltip extends Controller {
  connect() {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
  }
}
