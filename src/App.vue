<template>
  <div id="app">
    <div class="width-restricted">

        <GameView v-if="gaming" :path="gamePath"/>
        <div v-else>
            <div class="card" v-for="game in games" v-bind:key="game.path" @click="startGame(game.path)">
                {{game.name}}
            </div>
        </div>
    </div>

  </div>
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
import GameView from "@/components/GameView";

export default {
    name: 'app',
    components: {
        GameView
    },
    mounted: function () {
        fetch('./stories.json')
            .then(response => response.json())
            .then(obj => {
                this.games = obj.list
            })
    },
    data: function () {
        return {
            games: [],
            gaming: false,
            gamePath: ""
        }
    },

    methods: {

        startGame: function (path) {
            this.gamePath = path;
            this.gaming = true;
        }
    }
}
</script>

<style>
    * {
        box-sizing: border-box;
        user-select: none;
    }
    body {
        margin: 0;
    }
    #app {
        font-family: 'Avenir', Helvetica, Arial, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        background-color: darkslategrey;

        height: 100vh;
        width: 100%;
        overflow: auto;

        padding-top: 1rem;

    }
    .width-restricted {
        max-width: 500px;
        margin: 0 auto;
    }
    .card {
        display: inline-block;
        width: 45%;
        height: 45vh;

        margin: 1rem 2.5%;

        background-color: transparent;
        color: white;

        padding-top: 40%;
        text-align: center;

        border: 1px solid white;
        border-bottom: 5px solid white;
    }
</style>
