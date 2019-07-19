"use strict";
var KTSessionTimeoutDemo = function () {

    var initDemo = function () {
        $.sessionTimeout({
            title: 'Session Timeout Notification',
            message: 'Your session is about to expire.',
            keepAliveUrl: 'keepalive.jsp',
            redirUrl: 'UserController?pageName=logout',
            logoutUrl: 'UserController?pageName=logout',
            //warnAfter: 3000, //warn after 5 seconds
            warnAfter: 180000, //warn after 5 minutes
            //redirAfter: 35000, //redirect after 10 seconds
            redirAfter: 215000, //redirect after 10 seconds
            ignoreUserActivity: true,
            countdownMessage: 'Redirecting in {timer} seconds.',
            countdownBar: true
        });
    }

    return {
        //main function to initiate the module
        init: function () {
            initDemo();
        }
    };

}();

jQuery(document).ready(function() {    
    KTSessionTimeoutDemo.init();
});