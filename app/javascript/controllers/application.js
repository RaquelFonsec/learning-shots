import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
global.toastr = require("toastr")

//toastr.success('Meeting deleted successfully!');
//toastr.error('something went wrong!');
//toastr.warning('scheduled meeting!');
//toastr.info('Mensagem de informação!');
