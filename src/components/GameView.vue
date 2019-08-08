<template>
    <div id="GameView" @click="clickHandler">
<!--        <div>{{JSON.stringify(this.notes[this.now])}}</div>-->
        <div class="text" v-for="item in renderStack" v-bind:key="item.id">

                <Dialog v-if="item.type==='dialog'" :role="item.role" :msg="item.msg"> </Dialog>
                <Choose v-else-if="item.type==='choose'" :choices="item.choices" :values="variableList" :value="item.variable" :callback="chooseHandler"></Choose>


            <div class="mask" v-if="end">
                <p class="title">游戏结束</p>
                <p class="sub">{{endText}}</p>
            </div>
        </div>
    </div>
</template>

<script>
    import Dialog from "@/components/Dialog";
    import Choose from "@/components/Choose";

    const WAIT = 1;
    const NEXT = 0;

    export default {
        name: "GameView",
        components: {
            Choose,
            Dialog
        },

        data: function () {
            return {
                gameName: "",
                notes: {},
                variableList: {},
                renderStack:[],
                now: 0,
                end: false,
                endText: ""
            }
        },
        mounted: function() {
            fetch("./TestStory.json")
                .then(response => response.json())
                .then(res => {

                    this.gameName = res.name;
                    this.notes = res.notes;
                    this.process();

                })
        },
        methods: {
            debug: function() {
                console.log("now -> " + this.now);
                const current = this.notes[this.now];
                console.log(JSON.stringify(current))
            },

            process: function () {
                let res = NEXT;
                while(res !== WAIT) {
                    res = this.processCurrent();
                }
            },

            processCurrent: function () {
                const current = this.notes[this.now];


                // console.log(current);
                switch (current.type) {
                    case "start":
                        return this.requireNext();
                    // other cases ...
                    case "dialog":
                        return this.showCurrent();
                    case "choose":
                        return this.showCurrent();
                    case "branch":
                        // console.log("goto->"+current["branches"][this.variableList[current.variable]]);
                        return this.requireId(current["branches"][this.variableList[current.variable]]);
                    case "end":
                        return this.gameOver();
                    default:
                        console.error("Unknown type of -- " + current.type);
                        return WAIT;
                }
            },

            requireNext: function () {
                this.now += 1;
                return NEXT;
            },

            requireId: function (id) {
                this.now = id;
                return NEXT;
            },

            show: function(item) {
                this.renderStack.push(item);
                return WAIT;
            },

            showCurrent: function() {
                const current = this.notes[this.now];
                return this.show(current);
            },

            gameOver: function() {
                const current = this.notes[this.now];
                this.end = true;
                this.endText = current.msg;

                return WAIT;
            },



            clickHandler: function() {
                const current = this.notes[this.now];
                switch(current.type) {
                    case "dialog":
                        this.requireNext();
                        this.process();

                        break;
                    case "choose":
                        break;
                    case "end":
                        console.log("game over, refresh to play again.");
                        break;
                    default:
                        console.error("Unknown type -- " + current.type);
                }
            },

            chooseHandler: function() {
                this.requireNext();
                // alert();
                this.process();
                // alert();
            }
            // branch: function () {
            //     // console.log("branched. step is " + this.step);
            //     let chosen = this.variableList[this.noteBook.scripts[this.now].variable];
            //     // console.log("chosen is "+ chosen);
            //     this.now = this.noteBook.scripts[this.now].branch[chosen] -1;
            //     this.nextStep()
            //
            // },


            // clickScreen: function() {
            //     // console.log('ON-CLICK Now step is '+ this.step+", type is " + this.noteBook.scripts[this.step].type+".");
            //     switch (this.noteBook.scripts[this.now].type) {
            //         case 'start':
            //             this.nextStep();
            //             break;
            //         case 'dialog':
            //             this.nextStep();
            //             break;
            //         case 'choose':
            //             this.nextStep();
            //             break;
            //         case 'branch':
            //             // this.branch();
            //             break;
            //         case 'end':
            //             this.gameOver();
            //             break;
            //         default:
            //             console.log('unknow state' + this.noteBook.scripts[this.now].type)
            //     }
            //
            //
            // },


            // nextStep: function () {
            //
            //     this.now += 1;
            //     if(this.now>=this.noteBook.scripts.length)
            //         return;
            //
            //     if(this.noteBook.scripts[this.now].type === 'choose') {
            //         this.variableList[this.noteBook.scripts[this.now].variable] = 0
            //     }
            //
            //     this.renderStack.push(this.noteBook.scripts[this.now]);
            //
            //     // console.log('NEXT Now step is '+ this.now+", type is " + this.noteBook.scripts[this.now].type+".");
            // },


            // gameOver: function () {
            //     this.end = true;
            //     this.endText = this.noteBook.scripts[this.now].msg;
            //     console.log('Game over');
            // }
        }
    }
</script>

<style scoped>
    #GameView {
        height: 100vh;
        overflow: auto;
        background-color: darkslategrey;
    }
    .text {
        margin: .25rem;
        color:white;
    }
    .mask {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100vh;

        background-color: rgba(0,0,0,0.25);
        color: white;


        text-align: center;
    }
    .title {
        padding-top: 200px;
        font-size: 3rem;
    }
    .sub {

    }


</style>