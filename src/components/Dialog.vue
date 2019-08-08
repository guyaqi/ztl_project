<template>
        <div class="text">
            <div v-if="role!==''" class="name" >{{role}} </div>
            <div v-else class="placeholder"></div>
            {{msg}}
        </div>

</template>

<script>
    export default {
        name: "Dialog",
        props: [
            'role',
            'msg'
        ]
    }
</script>

<style scoped>
    .text {
        color: white;
    }
    .name {
        display: inline-block;
        /*border-bottom: 1px solid burlywood;*/
        border-right: 3px solid burlywood;
        padding-right: .25rem;
        width: 5rem;
        margin-right: .5rem;
        color: burlywood;

        text-align: right;
    }
    .placeholder {
        display: inline-block;
        padding-left: .25rem;
        width: 5rem;
        margin-right: .5rem;
    }

    .fade-enter-active, .fade-leave-active {
        transition: opacity .5s;
    }
    .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
        opacity: 0;
    }
</style>