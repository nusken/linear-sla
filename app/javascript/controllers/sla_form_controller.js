import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "filterType", "actionType" ]
  
  connect() {
    console.log("Hello, Stimulus!", this.element)
    this.filterTypeChanged()
    this.actionTypeChanged()
  }
  
  filterTypeChanged() {
    const filterType = this.filterTypeTarget.value
    document.querySelectorAll('.filter-value-options').forEach((element) => {
      if (element.dataset.filterType === filterType) {
        element.classList.remove('hidden')
        element.disabled = false
      } else {
        element.classList.add('hidden')
        element.disabled = true
      }
    })
  }
  
  actionTypeChanged(event) {
    const actionType = this.actionTypeTarget.value
    document.querySelectorAll('.action-details-options').forEach((element) => {
      if (element.dataset.actionType === actionType) {
        element.classList.remove('hidden')
        element.disabled = false
      } else {
        element.classList.add('hidden')
        element.disabled = true
      }
    })
  }
}
