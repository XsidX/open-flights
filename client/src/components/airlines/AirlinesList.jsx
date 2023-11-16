import { API_URL } from "../../constants";
import { useState, useEffect } from "react";
import { Link } from "react-router-dom";

const AirlinesList = () => {

    const [airlines, setAirlines] = useState([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState(null)

    useEffect(() => {
        async function fetchAirlines() {
            try {
                const response = await fetch(`${API_URL}/airlines`, {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                if (!response.ok) throw new Error(`${response.status} ${response.statusText}`)
                const json = await response.json()
                console.log(json)
                setAirlines(json.data)
            } catch (error) {
                setError(error)
            } finally {
                setLoading(false)
            }
        }
        fetchAirlines()
    }, [])

    return (
        <div className="airlines">
            {airlines.map(airline => (
                <li key={airline.attributes.id}>
                    <Link to={`/airlines/${airline.attributes.slug}`}>{airline.attributes.name}</Link>
                </li>
            ))}
        </div>
    );
}

export default AirlinesList;