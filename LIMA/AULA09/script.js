
document.getElementById('formContato').addEventListener('submit', async (event) => {

    event.preventDefault();

    const nome = document.getElementById('nome').value;
    const email = document.getElementById('email').value;
    const mensagem = document.getElementById('mensagem').value;

    const dados = {
        nome,
        email,
        mensagem
    };

    try {

        const resposta = await fetch('http://localhost:3000/api/mensagens', {
            method: 'POST',

            headers: {
                'Content-Type': 'application/json'
            },

            body: JSON.stringify(dados)
        });

        const resultado = await resposta.json();

        if (resposta.ok) {

            alert('Mensagem enviada com sucesso!');

            document.getElementById('formContato').reset();

        } else {

            alert(resultado.erro || 'Erro ao enviar mensagem.');
        }

    } catch (erro) {

        console.error('Erro na conexão:', erro);

        alert('Não foi possível conectar ao servidor.');
    }

});
