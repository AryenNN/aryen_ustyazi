$(function() {
  // Moment.js Zaman Dilimini Yapılandırma
  moment.locale('pt-BR');
  // Zaman işaretini başlatır
  function iniciarHorario() {
    document.getElementById('horario').innerHTML = "<h3>" + moment().format(`DD/MM/YYYY HH:mm:ss`) +  "</h3>";
    t = setTimeout(function() {
      iniciarHorario()
    }, 500);
  }
  iniciarHorario();
});
