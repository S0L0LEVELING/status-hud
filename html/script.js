const app = new Vue({
  el: "#app",

  data: {
    // Shared
    ResourceName: "_status",
    showUI: true,
    healthValue: 100,
    armorValue: 100,
    hungerValue: 100,
    thirstValue: 100,
    stressValue: 0,



  },

  methods: {
    createProgValue: function (values) {

      var heathVar = values.values.health;
      var armorVar = values.values.armor;
      var hungerVar = values.values.hunger;
      var thirstVar = values.values.thirst;
      var stressVar = values.values.stress;

      var healthBar = new ldBar("#health", {
        "stroke": '#f00',
        "stroke-width": 10,
      });

      healthBar.set(heathVar);

      var armorBar = new ldBar("#armor");
      armorBar.set(armorVar);

      var hungerBar = new ldBar("#hunger");
      hungerBar.set(hungerVar);

      var thirstBar = new ldBar("#thirst");
      thirstBar.set(thirstVar);

      var stressBar = new ldBar("#stress");
      stressBar.set(100);

    },



    ShowUI: function () {
      app.showUI = true;

    },

    HideUI() {
      axios
        .post(`http://${this.ResourceName}/HideUI`, {})
        .then(response => {
          this.showUI = false;

        })
        .catch(error => { });
    },

  }

});

// Listener from Lua CL
document.onreadystatechange = () => {
  if (document.readyState == "complete") {
    window.addEventListener("message", event => {
      ///////////////////////////////////////////////////////////////////////////
      // Character Main Menu
      ///////////////////////////////////////////////////////////////////////////

      if (event.data.type == "show_needs_ui") {

        app.ShowUI();
      } else if (event.data.type == "update_ui") {
        app.createProgValue(event.data);
      } else if (event.data.type == "close_needs_ui") {
        app.HideUI();
      }
    });
  }
};

