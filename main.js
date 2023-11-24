import "./style.css";
import { Elm } from "./src/Main.elm";

if (process.env.NODE_ENV === "development") {
    const ElmDebugTransform = await import("elm-debug-transformer")

    ElmDebugTransform.register({
        simple_mode: true
    })
}

const root = document.querySelector("#app div");
const savedMarkdown = localStorage.getItem('markdown') || 'type markdown here';
const app = Elm.Main.init({ node: root, flags: savedMarkdown });

app.ports.downloadMarkdown.subscribe(function(markdown) {
    var element = document.createElement('a');
    element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(markdown));
    element.setAttribute('download', 'markdown.md');

    element.style.display = 'none';
    document.body.appendChild(element);

    element.click();

    document.body.removeChild(element);
});

app.ports.saveMarkdown.subscribe(function(markdown) {
    localStorage.setItem('markdown', markdown);
});
