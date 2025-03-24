<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LukasJSP</title>
        <style>
            table {
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid black;
                padding: 8px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <h1>Gerador de Calendário</h1>
        <form method="post">
            <label for="ano">Ano:</label>
            <input type="number" id="ano" name="ano" min="0" required>
            <br><br>
            <label for="mes">Mês (1-12):</label>
            <input type="number" id="mes" name="mes" min="1" max="12" required>
            <br><br>
            <input type="submit" value="Gerar Calendário">
        </form>

        <hr>

        <%
            String anoStr = request.getParameter("ano");
            String mesStr = request.getParameter("mes");

            if (anoStr != null && mesStr != null) {
                int ano = Integer.parseInt(anoStr);
                int mes = Integer.parseInt(mesStr) - 1; 

                Calendar cal = Calendar.getInstance();
                cal.set(Calendar.YEAR, ano);
                cal.set(Calendar.MONTH, mes);
                cal.set(Calendar.DAY_OF_MONTH, 1);

                int primeiroDoMes = cal.get(Calendar.DAY_OF_WEEK);
                int ultimoDoMes = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

                String[] diasSemana = new DateFormatSymbols().getShortWeekdays();
                String[] mesesAno = new DateFormatSymbols().getMonths();

                out.println("<h2>Calendario de " + mesesAno[mes] + " de " + ano + "</h2>"); 
                out.println("<table>");
                out.println("<thead><tr>"); 

                for (int i = 1; i < diasSemana.length; i++){
                    out.println ("<th>" + diasSemana[i] + "</th>");
                }
                out.println("</tr></thead>"); 
                out.println("<tbody><tr>");

               
                for (int i = 1; i < primeiroDoMes; i++) {
                    out.println("<td></td>");
                }

                for (int dia = 1; dia <= ultimoDoMes; dia++){
                    out.println("<td>" + dia + "</td>");
                    cal.set(Calendar.DAY_OF_MONTH, dia);
                    int diaDaSemana = cal.get(Calendar.DAY_OF_WEEK);
                    if (diaDaSemana == Calendar.SATURDAY){
                        out.println("</tr><tr>");
                    }
                }

                int diaSemanaFinal = cal.get(Calendar.DAY_OF_WEEK);
                int diasRestantes = 7 - diaSemanaFinal;

                for (int i = 0; i < diasRestantes && diaSemanaFinal != Calendar.SUNDAY; i++) {
                    out.println("<td></td>");
                    cal.add(Calendar.DAY_OF_MONTH, 1);
                    diaSemanaFinal = cal.get(Calendar.DAY_OF_WEEK);
                }

                out.println("</tr></tbody>");
                out.println("</table>");

                out.println("<hr>");

            } else {
                out.println("<hr>");
                out.println("<p>Por favor, preencha o ano e o mês para gerar o calendário.</p>");
            }
        %>

    </body>
</html>
