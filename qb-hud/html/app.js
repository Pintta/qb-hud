const playerHud = {
    data() {
        return {
            hunger: 0,
            thirst: 0,
            show: false,
            showHunger: true,
            showThirst: true,
        }
    },
    destroyed() {
        window.removeEventListener('message', this.listener);
    },
    mounted() {
        this.listener = window.addEventListener('message', (event) => {
            if (event.data.action === 'hudtick') {
                this.hudTick(event.data);
            }
        });
    },
    methods: {
        hudTick(data) {
            this.show = data.show;
            this.hunger = data.hunger;
            this.thirst = data.thirst;
            if (data.hunger >= 100) {
                this.showHunger = false;
            } else {
                this.showHunger = true;
            }
            if (data.thirst >= 100) {
                this.showThirst = false;
            } else {
                this.showThirst = true;
            }
        }
    }
}
const app = Vue.createApp(playerHud);
app.use(Quasar)
app.mount('#ui-container');