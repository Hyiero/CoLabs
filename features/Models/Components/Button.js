
exports.buttonRef= function (id) {
    Function.prototype.getter = function(prop, get) {
        return Object.defineProperty(this.prototype, prop, {
            get: get,
            configurable: true
        });
    };

    Button = function Button(id) {
        this.id = id
    }

    Button.prototype = {

        get click() {
            return client.click("#" + this.id);
        },

        get isPresent() {
            return client.waitForExist("#" + this.id);
        }
    }
}
