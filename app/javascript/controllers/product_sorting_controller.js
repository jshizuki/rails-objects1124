import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-sorting"
export default class extends Controller {
  connect() {
    console.log("Connected to the product-sorting controller");
  }
}
