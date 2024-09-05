import React from "react";
import { createRoot } from "react-dom/client";

const componentsRegistry = {};

export function register(components) {
  Object.keys(components).forEach((name) => {
    if (name in componentsRegistry) {
      console.warn(
        "Called register for component that is already registered",
        name
      );
    }

    const component = components[name];
    if (!component) {
      throw new Error(`Called register with null component named ${name}`);
    }

    componentsRegistry[name] = component;
  });
}

function reactHtmlElements() {
  return document.getElementsByClassName("custom-react-component-render");
}

function render(el) {
  const name = el.getAttribute("data-component-name") || "";
  const domNodeId = el.getAttribute("data-dom-id") || "";
  const props = el.textContent !== null ? JSON.parse(el.textContent) : {};

  try {
    const domNode = document.getElementById(domNodeId);
    if (domNode) {
      const Component = componentsRegistry[name];

      if (Component != null) {
        const ReactElement = React.createElement(Component, props);

        const root = createRoot(domNode);
        root.render(ReactElement);

        window.reactComponentsRoots.push(root);
      }
    }
  } catch (e) {
    console.error(e.message);
    e.message = `Encountered an error while rendering component: ${name}. See above error message.`;
    throw e;
  }
}

function reactPageUnloaded() {
  for (const root of window.reactComponentsRoots ?? []) {
    root.unmount();
  }
}

function reactPageLoaded() {
  window.reactComponentsRoots = [];

  const els = reactHtmlElements();
  for (let i = 0; i < els.length; i += 1) {
    render(els[i]);
  }
}

function onPageReady(callback) {
  if (document.readyState === "complete") {
    callback();
  } else {
    document.addEventListener(
      "readystatechange",
      function onReadyStateChange() {
        onPageReady(callback);
        document.removeEventListener("readystatechange", onReadyStateChange);
      }
    );
  }
}

function onPageLoaded() {
  document.addEventListener("turbolinks:before-render", reactPageUnloaded);
  document.addEventListener("turbolinks:render", reactPageLoaded);
  reactPageLoaded();
}

onPageReady(onPageLoaded);
