<template>
    <div v-if="!used">
        <button v-for="item in choices" v-bind:key="item.id" @click.stop="action(item.id)">{{item.text}}</button>
    </div>
</template>

<script>
    export default {
        name: "Choose",
        props: [
            "choices",
            "values",
            "value",
            "callback"
        ],
        data: function() {
            return {
                used: false
            }
        },
        methods:{
            action: function (id) {
                console.log("value " + this.value + " -> " + id);
                this.values[this.value] = id;
                this.used = true;
                this.callback()
            }
        }
    }
</script>

<style scoped>
button {
    display: block;
    width:60%;
    border:1px solid white;
    border-left: 3px solid white;
    outline: none;
    background-color: transparent;
    color:white;
    font-size: 1rem;
    text-align: left;
    padding: .75rem;


    margin: .25rem 0 .25rem 5.75rem;
}
</style>