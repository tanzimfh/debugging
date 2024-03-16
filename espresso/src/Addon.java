package src;

class Addon extends Item {
    public Addon(String name) {
        super(name, 0, 1);
        this.price = this.calculatePrice();
    }

    public int calculatePrice() {
        switch (this.name) {
        case "cream":
            return 30;
        case "milk":
            return 20;
        default:
            return 10;
        }
    }
}
