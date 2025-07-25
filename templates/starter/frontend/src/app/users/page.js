"use client";

import { useEffect, useState } from "react";

export default function MyComponent() {
    const [data, setData] = useState(null);

    useEffect(() => {
        fetch("http://{{PROJECT_NAME}}.localhost/api/users", {
            credentials: "same-origin",
        })
            .then((response) => response.json())
            .then((data) => setData(data));
    }, []);
    return <div>{data ? <p>{data[0].mail}</p> : <p>Loading...</p>}</div>;
}
