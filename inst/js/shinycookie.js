Shiny.addCustomMessageHandler("shinycookie:get", function(message) {
    var cookie = (message.cookie) ? Cookies.get(message.cookie) : Cookies.get();
    Shiny.setInputValue(message.inputId, cookie);
});

Shiny.addCustomMessageHandler("shinycookie:set", function(message) {
    Cookies.set(message.cookie, message.value, message.options);
});

Shiny.addCustomMessageHandler("shinycookie:remove", function(message) {
    Cookies.remove(message.cookie, message.options);
});
